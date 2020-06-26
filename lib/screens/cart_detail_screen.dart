import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/cart_provider.dart';
import 'package:srShop/widgets/cart_item.dart';

class CartDetailScreen extends StatelessWidget {
  static const String route = "/cart-detail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Consumer<CartProvider>(
                      builder: (context, value, _) {
                        return Text(
                          "${value.getTotal}",
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color,
                          ),
                        );
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text("Order Now"),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                var cartData = cartProvider.items.values.toList();
                return ListView.builder(
                  itemBuilder: (context, index) => CartDetailItem(
                    id: cartData[index].id,
                    price: cartData[index].price,
                    quantity: cartData[index].quantity,
                    title: cartData[index].title,
                  ),
                  itemCount: cartProvider.itemCount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
