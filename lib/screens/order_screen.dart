import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/widgets/badge/badge_builder.dart';
import 'package:srShop/widgets/order/order_item.dart';
import '../widgets/drawer/drawer_widget.dart';
import '../providers/order_provider.dart';

class OrderScreen extends StatelessWidget {
  static const String route = "/Order-Screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder(),
      appBar: AppBar(
        title: Text("Your Orders"),
        actions: [
          BadgeBuilder(),
        ],
      ),
      body: Consumer<OrderProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return OrderItem(
                order: value.orders[index],
              );
            },
            itemCount: value.orderCount,
          );
        },
      ),
    );
  }
}
