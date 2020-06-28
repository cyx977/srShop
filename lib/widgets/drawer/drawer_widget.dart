import 'package:flutter/material.dart';
import 'package:srShop/screens/order_screen.dart';
import 'package:srShop/screens/products_overview_screen.dart';

class DrawerBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, ProductsOverviewScreen.route);
              },
              child: ListTile(
                title: Text("Home"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, OrderScreen.route);
              },
              child: ListTile(
                title: Text("Orders Screen"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
