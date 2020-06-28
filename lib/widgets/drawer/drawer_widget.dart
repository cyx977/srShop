import 'package:flutter/material.dart';
import '../../screens/cart_detail_screen.dart';
import '../../screens/order_screen.dart';
import '../../screens/products_overview_screen.dart';
import '../../widgets/drawer/drawer_menu_builder.dart';

class DrawerBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBar(title: Text("Heyyyy!")),
            Divider(),
            Column(
              children: [
                DrawerMenuBuilder(
                  title: "Home",
                  route: ProductsOverviewScreen.route,
                ),
                DrawerMenuBuilder(
                  title: "Orders Screen",
                  route: OrderScreen.route,
                ),
                DrawerMenuBuilder(
                  title: "Cart",
                  route: CartDetailScreen.route,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
