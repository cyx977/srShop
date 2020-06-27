import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/cart_provider.dart';
import 'package:srShop/providers/order_provider.dart';
import 'package:srShop/screens/cart_detail_screen.dart';
import 'package:srShop/screens/order_screen.dart';
import 'package:srShop/screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './screens/products_overview_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'SR Shop',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme(
            primary: Colors.red,
            primaryVariant: Colors.black,
            secondary: Colors.green,
            secondaryVariant: Colors.red,
            surface: Colors.red,
            background: Colors.red,
            error: Colors.red,
            onPrimary: Colors.red,
            onSecondary: Colors.red,
            onSurface: Colors.red,
            onBackground: Colors.red,
            onError: Colors.red,
            brightness: Brightness.light,
          ),
        ),
        routes: {
          /* home */ ProductsOverviewScreen.route: (context) =>
              ProductsOverviewScreen(),
          ProductDetailScreen.route: (context) => ProductDetailScreen(),
          CartDetailScreen.route: (context) => CartDetailScreen(),
          OrderScreen.route: (context) => OrderScreen(),
        },
      ),
    );
  }
}
