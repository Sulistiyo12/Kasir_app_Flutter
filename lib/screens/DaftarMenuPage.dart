import 'package:flutter/material.dart';
import 'package:kasir_app/models/MenuItemModel.dart';

class DaftarMenuPage extends StatelessWidget {
  final List<MenuItemModel> menuItems;

  DaftarMenuPage({required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(menuItems[index].name),
            subtitle: Text('Rp ${menuItems[index].price}'),
          );
        },
      ),
    );
  }
}
