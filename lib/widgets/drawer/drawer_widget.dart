import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/app_detail.dart';
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
            AppBar(
              title: Consumer<AppDetail>(
                builder: (context, value, child) => Text("${value.appName}"),
              ),
            ),
            Divider(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Column(
              children: [
                DrawerMenuBuilder(
                  title: "Home",
                  route: ProductsOverviewScreen.route,
                  icon: Icons.home,
                ),
                DrawerMenuBuilder(
                  title: "Cart",
                  route: CartDetailScreen.route,
                  icon: Icons.shopping_cart,
                ),
                DrawerMenuBuilder(
                  title: "Orders Screen",
                  route: OrderScreen.route,
                  icon: Icons.airport_shuttle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
