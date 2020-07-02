class MutableProduct {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavourite;

  MutableProduct({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavourite = false,
  });
}
