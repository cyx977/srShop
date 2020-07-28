import 'package:flutter/material.dart';
import '../../models/route/route_data_model.dart';
import '../../helpers/route/route_helper.dart';
import 'drawer_button_item_builder.dart';
import 'drawer_route_item_builder.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int buttonIndex = -1;
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Neesum"),
      leading: IconButton(
        icon: Icon(Icons.toc),
        onPressed: () {
          Navigator.pop(context);
        },
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
                  List<String> routesList = RouteHelper.menuItems.keys.toList();
                  List<RouteData> routeData =
                      RouteHelper.menuItems.values.toList();
                  List<MenuButton> _menuButton = RouteHelper.menuButtons;
                  var routeOnly = RouteHelper.drawerMenuLengthRouteOnly;
                  Widget returnable;
                  if (index < routeOnly) {
                    returnable = DrawerRouteItem(
                      icon: routeData[index].icon,
                      route: routesList[index],
                      title: routeData[index].title,
                    );
                  } else {
                    if (_menuButton.length > 0) {
                      if (buttonIndex < _menuButton.length - 1) {
                        buttonIndex++;
                        returnable = DrawerButtonItem(
                          icon: _menuButton[buttonIndex].icon,
                          onTapCallback: _menuButton[buttonIndex].onTap,
                          title: _menuButton[buttonIndex].title,
                        );
                      }
                    }
                  }
                  return returnable;
                },
                itemCount: RouteHelper.drawerMenuLengthTotal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
