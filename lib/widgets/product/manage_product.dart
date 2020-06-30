import 'package:flutter/material.dart';

class ManageProductWidget extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  ManageProductWidget({
    this.id,
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
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
