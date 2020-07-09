import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key key,
    @required TextEditingController imageUrlController,
  })  : _imageUrlController = imageUrlController,
        super(key: key);

  final TextEditingController _imageUrlController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(
        top: 8,
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: _imageUrlController.text.isEmpty
          ? FittedBox(
              child: Text("Enter a URL"),
            )
          : FittedBox(
              child: Image.network(
                _imageUrlController.text,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
