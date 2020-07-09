import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:srShop/models/mutableProduct_model.dart';
import 'package:srShop/providers/product_provider.dart';
import 'package:srShop/providers/products_provider.dart';
import 'package:srShop/screens/products_overview_screen.dart';
import 'package:srShop/widgets/drawer/drawer_widget.dart';

class EditProductScreen extends StatefulWidget {
  static const String route = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
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
    print("disposing focusnodes");
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
        print("invalid url");
        return;
      } else {
        print("valid");
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
    Provider.of<ProductsProvider>(context, listen: false).add(
      ProductProvider(
        id: DateTime.now().toString(),
        title: _editedProduct.title,
        description: _editedProduct.description,
        price: _editedProduct.price,
        imageUrl: _editedProduct.imageUrl,
      ),
    );
    Navigator.pushNamed(context, ProductsOverviewScreen.route);
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
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
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  onSaved: (newValue) {
                    _editedProduct.title = newValue;
                  },
                ),
                TextFormField(
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
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? FittedBox(
                              child: Text("Enter a URL"),
                            )
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Image Url"),
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
                          FocusScope.of(context).requestFocus(FocusNode());
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
