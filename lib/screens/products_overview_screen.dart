import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String route = "/";
  @override
  Widget build(BuildContext context) {
    print("building ProductsOverview Screen");
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Casual"),
        actions: [
          IconButton(
            icon: Icon(Icons.accessibility),
            onPressed: () {},
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
