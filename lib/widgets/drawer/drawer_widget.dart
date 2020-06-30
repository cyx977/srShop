import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/app_detail.dart';
import '../../widgets/drawer/drawer_menu_builder.dart';
import '../../const.dart';

class DrawerBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Consumer<AppDetail>(
        builder: (context, value, child) => Text("${value.appName}"),
      ),
    );
    return Drawer(
      elevation: 5,
      child: SafeArea(
        child: Column(
          children: [
            appBar,
            Divider(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  0.10,
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  0.60,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  List<String> routesList = routeConfig.keys.toList();
                  List<RouteData> routeData = routeConfig.values.toList();
                  if (routeData[index].addToMenu == false) {
                    return null;
                  }
                  return DrawerMenuBuilder(
                    icon: routeData[index].icon,
                    route: routesList[index],
                    title: routeData[index].title,
                  );
                },
                itemCount: routeConfig.length,
              ),
            ),
            // DrawerMenuBuilder(
            //   title: "Home",
            //   route: ProductsOverviewScreen.route,
            //   icon: Icons.home,
            // ),
            // DrawerMenuBuilder(
            //   title: "Cart",
            //   route: CartDetailScreen.route,
            //   icon: Icons.shopping_cart,
            // ),
            // DrawerMenuBuilder(
            //   title: "Orders Screen",
            //   route: OrderScreen.route,
            //   icon: Icons.airport_shuttle,
            // ),
            // DrawerMenuBuilder(
            //   title: "Manage Products",
            //   route: UserProductScreen.route,
            //   icon: Icons.edit,
            // ),
          ],
        ),
      ),
    );
  }
}
