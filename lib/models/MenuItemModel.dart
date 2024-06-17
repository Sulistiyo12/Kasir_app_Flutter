class MenuItemModel {
  final String name;
  final int price;
  int quantity;

  MenuItemModel({
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}
