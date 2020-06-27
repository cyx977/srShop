import 'package:flutter/material.dart';
import 'package:srShop/widgets/badge_builder.dart';
import 'package:srShop/widgets/drawer_widget.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  All,
  Favourite,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const route = "/";

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool popupSelection = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder(),
      appBar: AppBar(
        title: Text("Casual"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.All) {
                  popupSelection = true;
                } else {
                  popupSelection = false;
                }
              });
            },
            enabled: true,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: Text("Show Favourites"),
                value: FilterOptions.Favourite,
              ),
            ],
          ),
          BadgeBuilder(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ProductsGrid(
              popupSelection: popupSelection,
            ),
          ),
        ],
      ),
    );
  }
}
