import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srShop/providers/products_provider.dart';
import 'package:srShop/screens/edit_product_screen.dart';

class ManageProductWidget extends StatelessWidget {
  final String productId;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  ManageProductWidget({
    this.productId,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: Container(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Color.fromRGBO(112, 202, 237, 1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      EditProductScreen.route,
                      arguments: productId,
                    );
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () {
                    Future<bool> removeConfirmation = showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            FlatButton(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "No",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                          ],
                          title: Text(
                            "Are you sure you want to delete this product ?",
                          ),
                        );
                      },
                    );
                    removeConfirmation.then((bool result) {
                      if (result) {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .deleteProduct(productId)
                            .catchError((e) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Couldnt Delete"),
                            ),
                          );
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
