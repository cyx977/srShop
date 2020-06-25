import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final String popupSelection;
  ProductsGrid({this.popupSelection});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, child) => GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          var products = popupSelection == "all"
              ? provider.items.toList()
              : provider.items
                  .where((element) => element.isFavourite == true)
                  .toList();
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(),
          );
        },
        itemCount: popupSelection == "fav"
            ? provider.items
                .where((element) => element.isFavourite == true)
                .length
            : provider.items.length,
      ),
    );
  }
}
