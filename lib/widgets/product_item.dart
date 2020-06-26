import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var productProvider = Provider.of<ProductProvider>(context);
    // final String url = productProvider.imageUrl;
    // final String title = productProvider.title;
    // final double price = productProvider.price;
    // final String id = productProvider.id;
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) => ClipRRect(
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
                arguments: productProvider.id,
              );
              print(productProvider.id);
            },
            child: Image.network(
              productProvider.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black38,
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Provider.of<ProductProvider>(context).isFavourite
                    ? Theme.of(context).accentColor
                    : Colors.white,
              ),
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .toggleFavourite();
              },
              color: Theme.of(context).colorScheme.background,
            ),
            trailing: Consumer<CartProvider>(
              builder: (context, value, child) {
                return IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    value.addItem(
                      productId: productProvider.id,
                      title: productProvider.title,
                      price: productProvider.price,
                    );
                  },
                  color: Theme.of(context).accentColor,
                );
              },
            ),
            title: Center(
              child: Text(
                "${productProvider.title} \t \$ ${productProvider.price}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "lato",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
