import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              Icons.delete_sweep,
            ),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).clear();
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
                                print("cart empty");
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
