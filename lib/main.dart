import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/app_detail.dart';
import 'package:srShop/providers/cart_provider.dart';
import 'package:srShop/providers/order_provider.dart';
import './providers/products_provider.dart';
import 'const.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: const AppDetail(
            appName: "Nepali JhOlay",
            appUrl: "www.google.com",
          ),
        ),
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
        title: 'SR Shop', theme: themeData,
        routes: routes,

        //oldschool :P
        // routes: {
        //   /* home */ ProductsOverviewScreen.route: (context) =>
        //       ProductsOverviewScreen(),
        //   ProductDetailScreen.route: (context) => ProductDetailScreen(),
        //   CartDetailScreen.route: (context) => CartDetailScreen(),
        //   OrderScreen.route: (context) => OrderScreen(),
        //   ManageProductScreen.route: (context) => ManageProductScreen(),
        // },
      ),
    );
  }
}
