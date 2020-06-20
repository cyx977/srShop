import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  ProductProvider({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavourite = false,
  });
  void toggleFavourite(String id) {
    this.isFavourite = !this.isFavourite;
    notifyListeners();
  }
}
