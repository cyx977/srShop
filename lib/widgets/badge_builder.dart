import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/cart_provider.dart';
import 'package:srShop/screens/cart_detail_screen.dart';

import './badge.dart';

class BadgeBuilder extends StatelessWidget {
  const BadgeBuilder({
    Key key,
  }) : super(key: key);
  void navigatePage(BuildContext context) {
    Navigator.pushNamed(context, CartDetailScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            navigatePage(context);
          },
          child: Badge(
            child: child,
            value: value.itemRecursiveTotalCount.toString(),
          ),
        );
      },
      child: IconButton(
        icon: Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          navigatePage(context);
        },
      ),
    );
  }
}
