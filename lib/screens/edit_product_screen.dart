import "package:flutter/material.dart";
import 'package:srShop/widgets/drawer/drawer_widget.dart';

class EditProductScreen extends StatefulWidget {
  static const String route = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlController = TextEditingController();
  @override
  void dispose() {
    _priceNode.dispose();
    _descriptionNode.dispose();
    _imageUrlController.dispose();
    print("disposing focusnodes");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      drawer: DrawerBuilder(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_priceNode),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceNode,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_descriptionNode),
                //todo dispose focusnode
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionNode,
                maxLines: 3,
              ),
              Row(
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
                    child: Container(),
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: "Image Url"),
                  //   keyboardType: TextInputType.url,
                  //   maxLines: 3,
                  // ),
                ],
              )
              //             final String id;
              // final String title;
              // final String description;
              // final double price;
              // final String imageUrl;
              // bool isFavourite;
            ],
          ),
        ),
      ),
    );
  }
}
