import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/app_detail.dart';
import './providers/auth_provider.dart';
import './providers/cart_provider.dart';
import './providers/order_provider.dart';
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
          value: const AppDetailProvider(
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
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        title: 'SR Shop',
        theme: themeData,
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
