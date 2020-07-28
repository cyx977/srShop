import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/models/route/route_data_model.dart';
import 'package:srShop/screens/auth_screen.dart';
import 'package:srShop/screens/cart_detail_screen.dart';
import 'package:srShop/screens/edit_product_screen.dart';
import 'package:srShop/screens/order_screen.dart';
import 'package:srShop/screens/product_detail_screen.dart';
import 'package:srShop/screens/products_overview_screen.dart';
import 'package:srShop/screens/manage_products_screen.dart';
import '../../providers/auth_provider.dart';

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

  static List<MenuButton> _menuButton = [
    MenuButton(
      title: "Logout",
      icon: Icons.exit_to_app,
      addToMenu: true,
      onTap: ({@required BuildContext context}) async {
        print("Logged Out");
        Provider.of<AuthProvider>(context, listen: false).logout();
        Navigator.of(context).pop();
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
