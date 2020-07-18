import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/drawer/drawer_widget.dart';
import '../widgets/product/manage_product.dart';

class ManageProductScreen extends StatelessWidget {
  static const String route = "/manage-product";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacementNamed(context, EditProductScreen.route);
            },
          )
        ],
      ),
      drawer: DrawerBuilder(),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
        },
        child: Container(
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
                        productId: products[index].id,
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
      ),
    );
  }
}
