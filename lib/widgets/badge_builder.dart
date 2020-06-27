import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/cart_provider.dart';
import '../screens/cart_detail_screen.dart';

import './badge.dart';

class BadgeBuilder extends StatelessWidget {
  const BadgeBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return Badge(
          child: child,
          value: value.itemCount.toString(),
        );
      },
      child: IconButton(
        icon: Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          Navigator.pushNamed(context, CartDetailScreen.route);
        },
      ),
    );
  }
}
