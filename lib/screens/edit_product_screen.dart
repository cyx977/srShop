import "package:flutter/material.dart";
import 'package:srShop/models/mutableProduct_model.dart';
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
  void dispose() {
    //should dispose listener first before disposing focusnode
    _priceFocusNode.removeListener(_priceValidationListener);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_imageUrlListener);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    print("disposing focusnodes");
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_imageUrlListener);
    _priceFocusNode.addListener(_priceValidationListener);
    super.initState();
  }

  void _imageUrlListener() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _priceValidationListener() {
    if (!_priceFocusNode.hasFocus) {
      _formKey.currentState.validate();
    }
  }

  void _submitForm() {
    bool result = _formKey.currentState.validate();
    if (!result) {
      return;
    }
    _formKey.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.id);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
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
                    if (value.length < 5) {
                      return "Can't be less than 5 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                    helperStyle: TextStyle(
                      color: Colors.red,
                    ),
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
                    if (double.tryParse(value) is! double) {
                      return "Invalid Input";
                    }
                    if (value.length < 1) {
                      return "Can't be less than 5 characters";
                    }
                    if (value.length < 1) {
                      return "Can't be less than 5 characters";
                    }
                    if (value != "123") {
                      return "invalid pre test";
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
