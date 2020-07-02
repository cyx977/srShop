import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/screens/order_screen.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../widgets/cart/cart_item.dart';
import '../widgets/drawer/drawer_widget.dart';

class CartDetailScreen extends StatelessWidget {
  static const String route = "/cart-detail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder(),
      appBar: AppBar(
        title: Text("Your Cart"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Theme.of(context).errorColor.withOpacity(0.7),
            ),
            onPressed: () {
              CartProvider cartProvider =
                  Provider.of<CartProvider>(context, listen: false);
              if (cartProvider.itemRecursiveTotalCount > 0) {
                String removalString = cartProvider.itemRecursiveTotalCount == 1
                    ? "1 Item"
                    : "all ${cartProvider.itemRecursiveTotalCount} Items";
                var clear = showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                            "Are you Sure You want to clear $removalString from the Cart ?"),
                        actions: [
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                          FlatButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          )
                        ],
                      );
                    });
                clear.then((result) {
                  if (result) {
                    Provider.of<CartProvider>(context, listen: false).clear();
                  }
                });
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Cart is empty"),
                      actions: [
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.airport_shuttle,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, OrderScreen.route);
            },
          ),
        ],
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
                          "${value.getTotal.toStringAsFixed(2)}",
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
                  Consumer<OrderProvider>(
                    builder: (context, order, child) {
                      return Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return FlatButton(
                            child: Text("Order Now"),
                            onPressed: () {
                              if (cart.getTotal > 0) {
                                order.addOrder(
                                  cartItems: cart.items.values.toList(),
                                  total: cart.getTotal,
                                );
                                cart.clear();
                              } else {
                                //cart empty
                              }
                            },
                            textColor: Theme.of(context).primaryColor,
                          );
                        },
                      );
                    },
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
                    productId: cartProvider.items.keys.toList()[index],
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
