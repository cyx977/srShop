import 'package:flutter/material.dart';
import '../../models/order_model.dart' as provider;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final provider.OrderItem order;
  OrderItem({this.order});
  @override
  Widget build(BuildContext context) {
    var xx = DateFormat.E().format(DateTime.now());
    print(xx);
    print("Asd");
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${order.amount}"),
            subtitle: Text(
                "${DateFormat('y E MMMM d H:m \a', 'en_US').format(order.dateTime)}"),
          ),
        ],
      ),
    );
  }
}
