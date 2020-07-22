import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/badge/badge_builder.dart';
import '../widgets/order/order_item.dart';
import '../widgets/drawer/drawer_widget.dart';
import '../providers/order_provider.dart';

class OrderScreen extends StatefulWidget {
  static const String route = "/Order-Screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading = true;
  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<OrderProvider>(context, listen: false)
          .fetchAndSetOrder()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder(),
      appBar: AppBar(
        title: Text("Your Orders"),
        actions: [
          BadgeBuilder(),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<OrderProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderItem(
                      order: value.orders[index],
                    );
                  },
                  itemCount: value.orderCount,
                );
              },
            ),
    );
  }
}
