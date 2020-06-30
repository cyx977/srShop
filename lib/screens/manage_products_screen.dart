import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/products_provider.dart';
import 'package:srShop/widgets/drawer/drawer_widget.dart';
import 'package:srShop/widgets/product/manage_product.dart';

class ManageProductScreen extends StatelessWidget {
  static const String route = "/manage-product";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Products"),
      ),
      drawer: DrawerBuilder(),
      body: Container(
        height: 500,
        child: Consumer<ProductsProvider>(
          builder: (context, productsProvider, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var products = productsProvider.items;
                return Column(
                  children: [
                    ManageProductWidget(
                      description: products[index].description,
                      id: products[index].id,
                      imageUrl: products[index].imageUrl,
                      price: products[index].price,
                      title: products[index].title,
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: productsProvider.items.length,
            );
          },
        ),
      ),
    );
  }
}
