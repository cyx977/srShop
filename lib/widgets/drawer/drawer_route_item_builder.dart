import 'package:flutter/material.dart';

class DrawerRouteItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;

  const DrawerRouteItem({
    Key key,
    @required this.title,
    @required this.route,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      child: Card(
        color: Theme.of(context).colorScheme.primaryVariant,
        child: ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
