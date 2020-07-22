import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srShop/models/cart_model.dart';
import 'package:srShop/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders].reversed.toList();

  Future<void> fetchAndSetOrder() async {
    try {
      var url = "https://srshop-28285.firebaseio.com/orders.json";
      var response = await http.get(url).catchError((e) {
        throw e;
      });
      if (response.body != null) {
        var responseJson = jsonDecode(response.body) as Map<String, dynamic>;
        var keys = responseJson?.keys;
        if (keys == null) {
          return;
        }
        for (var k in keys) {
          if (_orders.where((order) => order.id == k).length == 0) {
            // print(responseJson[k]['products']);

            _orders.add(
              OrderItem(
                id: k,
                amount: double.tryParse(responseJson[k]['amount']),
                dateTime: DateTime.parse(responseJson[k]['dateTime']),
                products: (responseJson[k]['products'] as List)
                    .map(
                      (e) => CartItem(
                        id: e['id'],
                        price: e['price'],
                        quantity: e['quantity'],
                        title: e['title'],
                      ),
                    )
                    .toList(),
              ),
            );
          }
        }
        notifyListeners();
      }
    } catch (e) {
      print("E");
      print(e);
      throw e;
    }
  }

  Future<void> addOrder(
      {@required List<CartItem> cartItems, @required double total}) async {
    var url = "https://srshop-28285.firebaseio.com/orders.json";
    final dateTime = DateTime.now();
    final response = await http.post(
      url,
      body: jsonEncode(
        <String, dynamic>{
          "amount": "$total",
          "dateTime": "${dateTime.toIso8601String()}",
          "products": cartItems.map((e) {
            return <String, dynamic>{
              "id": e.id,
              "title": e.title,
              "quantity": e.quantity,
              "price": e.price,
            };
          }).toList(),
        },
      ),
    );
    _orders.add(
      OrderItem(
        id: jsonDecode(response.body)['name'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartItems,
      ),
    );
    notifyListeners();
  }

  int get orderCount => _orders.length;
}
