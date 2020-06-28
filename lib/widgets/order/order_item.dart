import 'package:flutter/material.dart';
import '../../models/order_model.dart' as orderProvider;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final orderProvider.OrderItem order;
  OrderItem({this.order});
  @override
  Widget build(BuildContext context) {
    print("Asd");
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text("NRS ${order.amount}"),
            subtitle: Text(
              "${DateFormat('y E MMMM d H:m \a', 'en_US').format(order.dateTime)}",
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
