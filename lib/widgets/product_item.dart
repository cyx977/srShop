import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  ProductItem({
    @required this.url,
    @required this.title,
    @required this.price,
  });
  final String url;
  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: GridTile(
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          title: Center(
            child: Text(
              "$title \t \$ $price",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "lato",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
