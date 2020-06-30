import "package:flutter/material.dart";
import 'package:srShop/widgets/drawer/drawer_widget.dart';

class EditProductScreen extends StatefulWidget {
  static const String route = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceNode = FocusNode();
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
                initialValue: "9840095714",
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(),
                onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
                focusNode: _priceNode,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_priceNode),
              ),
            ],
          ),
          autovalidate: true,
        ),
      ),
    );
  }
}
