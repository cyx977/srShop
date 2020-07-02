import 'package:flutter/material.dart';
import 'package:srShop/models/product_model.dart';

class ProductProvider extends Product with ChangeNotifier {
  ProductProvider({
    id,
    title,
    description,
    price,
    imageUrl,
    isFavourite = false,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          imageUrl: imageUrl,
        );
  void toggleFavourite() {
    this.isFavourite = !this.isFavourite;
    notifyListeners();
  }
}
