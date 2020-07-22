import 'dart:math';

import 'package:flutter/material.dart';
import '../../models/order_model.dart' as orderProvider;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final orderProvider.OrderItem order;
  OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.yellow.withOpacity(0.2),
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text("NRS ${widget.order.amount.toStringAsFixed(2)}"),
            subtitle: Text(
              "${DateFormat('y E MMMM d H:m \a', 'en_US').format(widget.order.dateTime)}",
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
              height: min(
                widget.order.products.length * 20 + 15.0,
                180,
              ),
              child: ListView(
                children: [
                  ...widget.order.products.map((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${e.title}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${e.quantity} x NRS ${e.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
