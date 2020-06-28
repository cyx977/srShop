import 'package:flutter/material.dart';

class DrawerMenuBuilder extends StatelessWidget {
  final String title;
  final String route;
  const DrawerMenuBuilder({
    Key key,
    @required this.title,
    @required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      child: Card(
        color: Theme.of(context).accentColor,
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
