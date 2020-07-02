import 'package:flutter/material.dart';

class MutableProduct {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavourite;

  MutableProduct({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });
}
