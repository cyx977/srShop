import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/product_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("building ProductsGrid widget");
    var provider = Provider.of<ProductsProvider>(context, listen: false);
    List<ProductProvider> products = provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        return ChangeNotifierProvider(
          create: (context) => products[index],
          child: ProductItem(),
        );
      },
      itemCount: products.length,
    );
  }
}
