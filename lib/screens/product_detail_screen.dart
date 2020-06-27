import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/product_provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String route = "/product-detail";

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    var providerData = Provider.of<ProductsProvider>(context, listen: false);
    ProductProvider product = providerData.findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "\$${product.price}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                "${product.description}",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
