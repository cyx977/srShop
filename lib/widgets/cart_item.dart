import 'package:flutter/material.dart';

class CartDetailItem extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;

  CartDetailItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Text("\$$price"),
          title: Text(title),
          subtitle: Text("Total: \$${price * quantity}"),
          trailing: Text("$quantity x"),
        ),
      ),
    );
  }
}
