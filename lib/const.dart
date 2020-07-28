import 'package:flutter/material.dart';
import 'package:srShop/screens/auth_screen.dart';
import 'package:srShop/screens/cart_detail_screen.dart';
import 'package:srShop/screens/edit_product_screen.dart';
import 'package:srShop/screens/order_screen.dart';
import 'package:srShop/screens/product_detail_screen.dart';
import 'package:srShop/screens/products_overview_screen.dart';
import 'package:srShop/screens/manage_products_screen.dart';

class RouteData {
  final String title;
  final IconData icon;
  final bool addToMenu;
  var instance;
  RouteData({
    @required this.title,
    @required this.icon,
    this.addToMenu = true,
    @required this.instance,
  });
}

class RouteHelper {
  static Map<String, RouteData> _routeConfig = {
    ProductsOverviewScreen.route: RouteData(
      icon: Icons.home,
      title: "Home",
      instance: ProductsOverviewScreen(),
    ),
    CartDetailScreen.route: RouteData(
      title: "Cart",
      icon: Icons.shopping_cart,
      instance: CartDetailScreen(),
    ),
    OrderScreen.route: RouteData(
      title: "Orders Screen",
      icon: Icons.airport_shuttle,
      instance: OrderScreen(),
    ),
    ManageProductScreen.route: RouteData(
      title: "Manage Products",
      icon: Icons.edit,
      instance: ManageProductScreen(),
    ),
    ProductDetailScreen.route: RouteData(
      icon: Icons.details,
      instance: ProductDetailScreen(),
      title: "Product Detail",
      addToMenu: false,
    ),
    EditProductScreen.route: RouteData(
      icon: Icons.edit,
      title: "Edit Product",
      addToMenu: true,
      instance: EditProductScreen(),
    ),
    AuthScreen.route: RouteData(
      icon: Icons.verified_user,
      instance: AuthScreen(),
      title: "Authentication",
      addToMenu: true,
    ),
  };

  // static List<MenuButton> _menuButton = [
  //   MenuButton(
  //     title: "Logout",
  //     icon: Icons.exit_to_app,
  //     addToMenu: true,
  //     onTap: ({@required BuildContext context}) async {
  //       print("Logged Out");
  //       try {
  //         // SharedPreferences _prefs = await SharedPreferences.getInstance();
  //         // _prefs.clear();
  //         // Navigator.pushReplacementNamed(context, LoginScreen.route);
  //       } catch (e) {
  //         throw e;
  //       }
  //     },
  //   ),
  //   MenuButton(
  //     title: "Debug",
  //     icon: Icons.attachment,
  //     addToMenu: true,
  //     onTap: ({@required BuildContext context}) async {
  //       print("Debug");
  //     },
  //   ),
  //   MenuButton(
  //     title: "Debug1",
  //     icon: Icons.attachment,
  //     addToMenu: false,
  //     onTap: ({@required BuildContext context}) async {
  //       print("Debug1");
  //     },
  //   ),
  // ];

  static int get drawerMenuLengthTotal {
    int length = 0;
    _routeConfig.forEach((key, config) {
      if (config.addToMenu) {
        length++;
      }
    });
    _menuButton.forEach((element) {
      if (element.addToMenu) {
        length++;
      }
    });
    return length;
  }

  static int get drawerMenuLengthRouteOnly {
    int length = 0;
    _routeConfig.forEach((key, config) {
      if (config.addToMenu) {
        length++;
      }
    });
    return length;
  }

  static List<MenuButton> _menuButton = [
    MenuButton(
      title: "Logout",
      icon: Icons.exit_to_app,
      addToMenu: true,
      onTap: ({@required BuildContext context}) async {
        print("Logged Out");
        try {
          // SharedPreferences _prefs = await SharedPreferences.getInstance();
          // _prefs.clear();
          // Navigator.pushReplacementNamed(context, LoginScreen.route);
        } catch (e) {
          throw e;
        }
      },
    ),
    MenuButton(
      title: "Debug",
      icon: Icons.attachment,
      addToMenu: true,
      onTap: ({@required BuildContext context}) async {
        print("Debug");
      },
    ),
    MenuButton(
      title: "Debug1",
      icon: Icons.attachment,
      addToMenu: false,
      onTap: ({@required BuildContext context}) async {
        print("Debug1");
      },
    ),
  ];

  // static int get drawerMenuLengthTotal {
  //   int length = 0;
  //   _routeConfig.forEach((key, config) {
  //     if (config.addToMenu) {
  //       length++;
  //     }
  //   });
  //   _menuButton.forEach((element) {
  //     if (element.addToMenu) {
  //       length++;
  //     }
  //   });
  //   return length;
  // }

  // static int get drawerMenuLengthRouteOnly {
  //   int length = 0;
  //   _routeConfig.forEach((key, config) {
  //     if (config.addToMenu) {
  //       length++;
  //     }
  //   });
  //   return length;
  // }

  static Map<String, RouteData> get menuItems {
    Map<String, RouteData> finalMenuItems;
    finalMenuItems = {..._routeConfig};
    finalMenuItems.removeWhere((key, value) => value.addToMenu == false);
    return finalMenuItems;
  }

  static List<MenuButton> get menuButtons {
    List<MenuButton> finalMenuItems;
    finalMenuItems = [..._menuButton];
    finalMenuItems.removeWhere((element) => element.addToMenu == false);
    return finalMenuItems;
  }

  static Map<String, Widget Function(BuildContext)> get routes {
    Map<String, Widget Function(BuildContext)> routes =
        _routeConfig.map((key, value) {
      return MapEntry(key, (context) => value.instance);
    });
    return routes;
  }
}

// Map<String, RouteData> get menuItems {
//   Map<String, RouteData> finalMenuItems;
//   finalMenuItems = Map.from(routeConfig);
//   finalMenuItems.removeWhere((key, value) => value.addToMenu == false);
//   return finalMenuItems;
// }

// int get drawerMenuLength {
//   int length = 0;
//   routeConfig.forEach((key, value) {
//     if (value.addToMenu) {
//       length++;
//     }
//   });
//   return length;
// }

final themeData = ThemeData(
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
    primary: Colors.green,
    primaryVariant: Colors.green,
    secondary: Colors.green,
    secondaryVariant: Colors.yellow,
    surface: Colors.green,
    background: Colors.green,
    error: Colors.green,
    onPrimary: Colors.red,
    onSecondary: Colors.red,
    //TextFormField's color is changed with ColorScheme's onSurface
    onSurface: Colors.purple,
    onBackground: Colors.red,
    onError: Colors.red,
    brightness: Brightness.light,
  ),
);

// final Map<String, Widget Function(BuildContext)> routes =
//     routeConfig.map((key, value) {
//   return MapEntry(key, (context) => value.instance);
// });

class MenuButton {
  final String title;
  final IconData icon;
  final bool addToMenu;
  final Function onTap;
  const MenuButton({
    @required this.title,
    @required this.icon,
    @required this.onTap,
    this.addToMenu = true,
  });
}
