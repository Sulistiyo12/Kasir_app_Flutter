import 'package:flutter/material.dart';
import 'MenuItemModel.dart';

class CartModel extends ChangeNotifier {
  final List<MenuItemModel> _items = [];

  List<MenuItemModel> get items => _items;

  List<Map<String, dynamic>> getOrderedItemsWithQuantities() {
    return _items
        .map((item) => {
              'name': item.name,
              'quantity': item.quantity,
            })
        .toList();
  }

  void add(MenuItemModel item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(MenuItemModel item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void removeLast() {
    if (_items.isNotEmpty) {
      _items.removeLast();
      notifyListeners();
    }
  }

  int get totalPrice => _items.fold(
      0, (total, current) => total + (current.price * current.quantity));
}
