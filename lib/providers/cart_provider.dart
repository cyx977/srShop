import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => {..._items};

  int get itemRecursiveTotalCount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  int get itemCount => _items.length;

  void clear() {
    _items = {};
    notifyListeners();
  }

  double get getTotal {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void addItem({
    @required String productId,
    @required String title,
    @required double price,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }
}
