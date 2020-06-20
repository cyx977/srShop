import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/screens/product_detail.dart';
import './providers/products_provider.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
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
              brightness: Brightness.light),
        ),
        routes: {
          /* home */ ProductsOverviewScreen.route:(context) => ProductsOverviewScreen(),
          ProductDetailScreen.route: (context) => ProductDetailScreen(),

        },
      ),
    );
  }
}
