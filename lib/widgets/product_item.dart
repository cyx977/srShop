import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/products_provider.dart';
import 'package:srShop/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  ProductItem({
    @required this.id,
    @required this.url,
    @required this.title,
    @required this.price,
  });
  final String url;
  final String title;
  final double price;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailScreen.route,
              arguments: id,
            );
          },
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Provider.of<Products>(context).findById(id).isFavourite
                  ? Theme.of(context).accentColor
                  : Colors.white,
            ),
            onPressed: () {
              Provider.of<Products>(context, listen: false).toggleFavourite(id);
            },
            color: Theme.of(context).colorScheme.background,
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
