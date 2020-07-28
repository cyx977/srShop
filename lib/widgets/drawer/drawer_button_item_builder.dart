import 'package:flutter/material.dart';

class DrawerButtonItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTapCallback;

  const DrawerButtonItem({
    Key key,
    @required this.title,
    @required this.onTapCallback,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapCallback(context: context);
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
