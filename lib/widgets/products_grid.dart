import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<ProductsProvider>(context, listen: false);
    // List<ProductProvider> products = provider.items;
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
          var products = provider.items;
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(),
          );
        },
        itemCount: provider.items.length,
      ),
    );
  }
}
