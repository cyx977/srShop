import 'package:flutter/material.dart';
import 'package:srShop/screens/cart_detail_screen.dart';
import 'package:srShop/screens/order_screen.dart';
import 'package:srShop/screens/products_overview_screen.dart';
import 'package:srShop/screens/user_products_screen.dart';

class RouteData {
  String title;
  IconData icon;
  RouteData({@required this.title, @required this.icon});
}

Map<String, RouteData> routeConfig = {
  ProductsOverviewScreen.route: RouteData(icon: Icons.home, title: "Home"),
  CartDetailScreen.route: RouteData(title: "Cart", icon: Icons.shopping_cart),
  OrderScreen.route:
      RouteData(title: "Orders Screen", icon: Icons.airport_shuttle),
  UserProductScreen.route: RouteData(title: "Manage Products", icon: Icons.edit)
};
