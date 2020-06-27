import 'package:flutter/material.dart';
import 'package:srShop/models/cart_model.dart';
import 'package:srShop/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders];

  void addOrder({@required List<CartItem> cartItems, @required double total}) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartItems,
      ),
    );
    print(_orders[0].amount);
    notifyListeners();
  }

  int get orderCount => _orders.length;
}
