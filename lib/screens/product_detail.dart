import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/product_provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String route = "/product-detail";

  @override
  Widget build(BuildContext context) {
    print("building ProductDetail Screen");

    String productId = ModalRoute.of(context).settings.arguments as String;
    var providerData = Provider.of<ProductsProvider>(context, listen: false);
    ProductProvider product = providerData.findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
