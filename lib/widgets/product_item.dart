import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/products_provider.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    final String url = productProvider.imageUrl;
    final String title = productProvider.title;
    final double price = productProvider.price;
    final String id = productProvider.id;
    print("building ProductItem widget");
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
              color: Provider.of<ProductsProvider>(context)
                      .findById(id)
                      .isFavourite
                  ? Theme.of(context).accentColor
                  : Colors.white,
            ),
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .toggleFavourite(id);
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
