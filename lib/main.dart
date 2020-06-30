import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/app_detail.dart';
import 'package:srShop/providers/cart_provider.dart';
import 'package:srShop/providers/order_provider.dart';
import 'package:srShop/screens/cart_detail_screen.dart';
import 'package:srShop/screens/order_screen.dart';
import 'package:srShop/screens/product_detail_screen.dart';
import 'package:srShop/screens/manage_products_screen.dart';
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
        title: 'SR Shop',
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.green,
            actionTextColor: Colors.grey,
            contentTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            behavior: SnackBarBehavior.floating,
          ),
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme(
            primary: Colors.red,
            primaryVariant: Colors.black,
            secondary: Colors.green,
            secondaryVariant: Color.fromRGBO(112, 202, 237, 1),
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
          ManageProductScreen.route: (context) => ManageProductScreen(),
        },
      ),
    );
  }
}
