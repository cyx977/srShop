import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/cart_provider.dart';

class CartDetailItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String title;
  final int quantity;

  CartDetailItem(
      {@required this.id,
      @required this.price,
      @required this.title,
      @required this.quantity,
      @required this.productId});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<CartProvider>(
          context,
          listen: false,
        ).removeFromCart(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Are you Sure you want to remove $quantity $title from the cart ??",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("You can again add these items to the cart"),
            actions: [
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      // direction: DismissDirection.startToEnd,
      background: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
      key: ValueKey(id),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("$price"),
              )),
            ),
            title: Text(title),
            subtitle: Text("Total: NRS ${price * quantity}"),
            trailing: Text("X$quantity"),
          ),
        ),
      ),
    );
  }
}
