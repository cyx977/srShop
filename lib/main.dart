import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/product_provider.dart';
import 'package:srShop/screens/auth_screen.dart';
import 'package:srShop/screens/products_overview_screen.dart';
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
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (context) =>
              ProductsProvider(<ProductProvider>[], authToken: null),
          update: (context, auth, products) => ProductsProvider(products.items,
              authToken: auth.getAuth['token']),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          print(auth.isAuth);
          return MaterialApp(
            title: 'SR Shop',
            theme: themeData,
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: RouteHelper.routes,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
