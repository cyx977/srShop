import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srShop/models/exception_model.dart';
import '../providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {
  final String authToken;
  ProductsProvider(this._items, {@required this.authToken});
  List<ProductProvider> _items; // = [];

  /*List<ProductProvider> _items = [
    ProductProvider(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 495.00,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductProvider(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 600.00,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 299.00,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductProvider(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 1200.00,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    ProductProvider(
      id: 'p5',
      title: 'Purple Shirt',
      description: 'A purple shirt - it is pretty geek!',
      price: 775.00,
      imageUrl:
          'https://explosiontshirt.com/wp-content/uploads/2018/10/men-purple-tshirt-gildan-adult-front1.jpg',
    ),
    ProductProvider(
      id: 'p6',
      title: 'Brown Trousers',
      description: 'A nice pair of trousers.',
      price: 900.00,
      imageUrl:
          'https://contents.mediadecathlon.com/p1641091/kf861c49b737a4d629aa737a501aac642/1641091_default.jpg?format=auto&quality=60&f=800x0',
    ),
  ];*/

  ProductProvider findById(String id) =>
      _items.firstWhere((element) => element.id == id);

  List<ProductProvider> get items => [..._items];

  Future<void> fetchProducts() async {
    try {
      final url =
          "https://srshop-28285.firebaseio.com/products.json/?auth=$authToken";
      var response = await http.get(url).catchError((e) {
        throw e;
      });
      if (response.body != null) {
        var responseJson = jsonDecode(response.body) as Map<String, dynamic>;
        var keys = responseJson.keys;
        for (var k in keys) {
          if (_items.where((product) => product.id == k).length == 0) {
            _items.add(
              ProductProvider(
                id: k,
                description: responseJson[k]['description:'],
                imageUrl: responseJson[k]['imageUrl'],
                title: responseJson[k]['title'],
                price: double.tryParse(responseJson[k]['price']),
              ),
            );
          }
        }
      }
      notifyListeners();
    } catch (e) {
      print("E");
      throw e;
    }
  }

  Future<void> updateProduct(ProductProvider product) async {
    final _item = findById(product.id);
    String productId = _item.id;
    var url = "https://srshop-28285.firebaseio.com/products/$productId.json";
    http
        .patch(
      url,
      body: jsonEncode(<String, String>{
        "title": "${product.title}",
        "description": "${product.description}",
        "imageUrl": "${product.imageUrl}",
        "price": "${product.price}",
      }),
    )
        .then((http.Response response) {
      // var resp = jsonDecode(response.body);
      print("error vaye ni chalcha");
      int productIndex = _items.indexWhere((prod) => prod.id == product.id);
      _items[productIndex] = product;
      notifyListeners();
    }).catchError(
      (e) {
        throw HttpException(message: e.toString());
      },
    );
  }

  Future<void> addProduct(ProductProvider product) {
    const url = "https://srshop-28285.firebaseio.com/products.json";
    return http
        .post(
      url,
      body: jsonEncode(<String, String>{
        "title": "${product.title}",
        "description": "${product.description}",
        "imageUrl": "${product.imageUrl}",
        "price": "${product.price}",
      }),
    )
        .then(
      (http.Response response) {
        print("still runs");
        var resp = jsonDecode(response.body);
        _items.add(
          ProductProvider(
            id: resp['name'],
            description: product.description,
            imageUrl: product.imageUrl,
            price: product.price,
            isFavourite: product.isFavourite,
            title: product.title,
          ),
        );
        notifyListeners();
      },
    ).catchError(
      (e) {
        throw e;
      },
    );
  }

  Future<void> deleteProduct(String productId) async {
    // var url = "https://srshop-28285.firebaseio.com/products/$productId.json";
    // http.delete(url).then((_) {
    //   _items.removeWhere((ProductProvider product) => product.id == productId);
    //   notifyListeners();
    // }).catchError((e) {
    //   throw e;
    // });

    var url = "https://srshop-28285.firebaseio.com/products/$productId.json";
    final _indexExistingProduct =
        _items.indexWhere((product) => product.id == productId);
    final _existingProduct = _items[_indexExistingProduct];
    _items.removeAt(_indexExistingProduct);
    notifyListeners();
    await http.patch(url).catchError((e) {
      _items.insert(_indexExistingProduct, _existingProduct);
      notifyListeners();
      throw HttpException(message: e.toString());
    });
  }
}
