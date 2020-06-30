import 'package:flutter/material.dart';
import 'package:srShop/widgets/drawer/drawer_widget.dart';

class UserProductScreen extends StatelessWidget {
  static const String route = "/manage-product";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Products"),
      ),
      drawer: DrawerBuilder(),
    );
  }
}
