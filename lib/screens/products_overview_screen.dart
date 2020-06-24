import 'package:downloads_path_provider/downloads_path_provider.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/products_grid.dart';

void test() async {
  if (await Permission.storage.request().isGranted) {
    print("granted Storage");
  }
  // if (await Permission.contacts.request().isGranted) {
  //   print("granted Storage");
  // }
}

void writeTest() {
  DownloadsPathProvider.downloadsDirectory.then((value) => print(value));
  // getApplicationSupportDirectory().then((value) => print(value));
  // File("/storage/emulated/0/test.txt").create();
}

class ProductsOverviewScreen extends StatelessWidget {
  static const String route = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Casual"),
        actions: [
          IconButton(
            icon: Icon(Icons.accessibility),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ProductsGrid(),
          ),
          RaisedButton(
            onPressed: test,
            child: Text("test"),
          ),
          RaisedButton(
            onPressed: writeTest,
            child: Text("TestWrite"),
          ),
        ],
      ),
    );
  }
}
