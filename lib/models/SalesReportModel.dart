import 'package:flutter/material.dart';
import 'package:kasir_app/models/MenuItemModel.dart';

class SalesReportModel extends ChangeNotifier {
  final List<SalesReport> _reports = [];

  List<SalesReport> get reports => _reports;

  void addReport(List<MenuItemModel> items, List<int> quantities,
      int totalPrice, int totalPricePaid, int changeAmount) {
    _reports.add(SalesReport(
      items: items,
      quantities: quantities,
      totalPrice: totalPrice,
      totalPricePaid: totalPricePaid,
      changeAmount: changeAmount,
      dateTime: DateTime.now(),
    ));
    notifyListeners();
  }
}

class SalesReport {
  final List<MenuItemModel> items;
  final List<int> quantities;
  final int totalPrice;
  final int totalPricePaid;
  final int changeAmount;
  final DateTime dateTime;

  SalesReport({
    required this.items,
    required this.quantities,
    required this.totalPrice,
    required this.totalPricePaid,
    required this.changeAmount,
    required this.dateTime,
  });
}
