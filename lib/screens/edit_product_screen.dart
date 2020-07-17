import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:srShop/models/product_model.dart';
import '../models/mutableProduct_model.dart';
import '../providers/product_provider.dart';
import '../providers/products_provider.dart';
import '../screens/products_overview_screen.dart';
import '../widgets/drawer/drawer_widget.dart';
import '../widgets/edit_product/image_preview.dart';

class EditProductScreen extends StatefulWidget {
  static const String route = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _initValues = {
    'id': null,
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
    'isFavourite': false,
  };
  bool isInit = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    String productId = ModalRoute.of(context).settings.arguments as String;
    if (isInit) {
      if (productId != null) {
        Product product =
            Provider.of<ProductsProvider>(context).findById(productId);
        _initValues['id'] = product.id;
        _initValues['title'] = product.title;
        _initValues['price'] = product.price.toString();
        _initValues['description'] = product.description;
        _imageUrlController.text = product.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = MutableProduct();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_imageUrlListener);
    super.initState();
  }

  @override
  void dispose() {
    //should dispose listener first before disposing focusnode
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_imageUrlListener);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _imageUrlListener() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.endsWith(".jpg") &&
              !_imageUrlController.text.endsWith(".png") &&
              !_imageUrlController.text.endsWith(".jpeg")) ||
          (!_imageUrlController.text.startsWith("http:") &&
              !_imageUrlController.text.startsWith("https:"))) {
        return;
      }
      setState(() {});
    }
  }

  void _submitForm() {
    bool isValidated = _formKey.currentState.validate();
    if (!isValidated) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_initValues['id'] != null) {
      Provider.of<ProductsProvider>(context, listen: false).updateProduct(
        ProductProvider(
          id: _initValues['id'],
          description: _editedProduct.description,
          imageUrl: _editedProduct.imageUrl,
          price: _editedProduct.price,
          title: _editedProduct.title,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamed(context, ProductsOverviewScreen.route);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(
        ProductProvider(
          id: DateTime.now().toString(),
          title: _editedProduct.title,
          description: _editedProduct.description,
          price: _editedProduct.price,
          imageUrl: _editedProduct.imageUrl,
        ),
      )
          .then(
        (value) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushNamed(context, ProductsOverviewScreen.route);
        },
      ).catchError((e) {
        print("error vayo post garda");
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("An Error Occured"),
              content: Text("Something Went Wrong"),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
            );
          },
        );
      }).then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushNamed(context, ProductsOverviewScreen.route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitForm,
          )
        ],
      ),
      drawer: DrawerBuilder(),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: "Title",
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                        onSaved: (newValue) {
                          _editedProduct.title = newValue;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a Price";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter a valid number";
                          }
                          if (double.tryParse(value) <= 0) {
                            return "Price should be greater than 0";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: "Price"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode),
                        onSaved: (newValue) {
                          _editedProduct.price = double.parse(newValue);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: InputDecoration(labelText: "Description"),
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        maxLines: 3,
                        onSaved: (newValue) {
                          _editedProduct.description = newValue;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a Description";
                          }
                          if (value.length < 10) {
                            return "Should be atleast 10 characters long";
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ImagePreview(imageUrlController: _imageUrlController),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Image Url"),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (value) {
                                _submitForm();
                              },
                              onSaved: (newValue) {
                                _editedProduct.imageUrl = newValue;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter a Image Url";
                                }
                                if (!value.startsWith("http") &&
                                    !value.startsWith("https")) {
                                  return "Not a valid url";
                                }
                                if (!value.endsWith("jpg") &&
                                    !value.endsWith("png") &&
                                    !value.endsWith("jpeg")) {
                                  return "Invalid Image Type";
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
