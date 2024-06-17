import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kasir_app/models/CartModel.dart';
import 'package:kasir_app/models/MenuItemModel.dart';
import 'package:kasir_app/screens/PaymentPage.dart';
import 'package:kasir_app/screens/DaftarMenuPage.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<MenuItemModel> menuItems = [
    MenuItemModel(name: 'Mie Ayam Original', price: 15000),
    MenuItemModel(name: 'Mie Ayam Bakso', price: 20000),
    MenuItemModel(name: 'Mie Ayam Pangsit', price: 22000),
  ];

  List<MenuItemModel> filteredMenuItems = [];
  bool isSearchPerformed = false;
  bool isDrawerOpen = false;

  @override
  void initState() {
    filteredMenuItems.addAll(menuItems);
    super.initState();
  }

  void _filterMenu(String query) {
    setState(() {
      if (query.isNotEmpty) {
        isSearchPerformed = true;
        filteredMenuItems = menuItems
            .where(
                (menu) => menu.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        isSearchPerformed = false;
        filteredMenuItems.clear();
        filteredMenuItems.addAll(menuItems);
      }
    });
  }

  void _toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  void _tambahMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String namaMenu = '';
        int hargaMenu = 0;

        return AlertDialog(
          title: Text('Tambah Menu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Nama Menu'),
                onChanged: (value) {
                  namaMenu = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Harga Menu'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  hargaMenu = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                if (namaMenu.isNotEmpty && hargaMenu > 0) {
                  var newMenuItem =
                      MenuItemModel(name: namaMenu, price: hargaMenu);
                  menuItems.add(newMenuItem);
                  filteredMenuItems.add(newMenuItem);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Penjualan'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Setting'),
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('Tambah Menu'),
              onTap: _tambahMenu,
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Daftar Menu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DaftarMenuPage(menuItems: menuItems),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari Menu',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterMenu,
            ),
          ),
          isSearchPerformed
              ? Expanded(
                  child: ListView.builder(
                    itemCount: filteredMenuItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredMenuItems[index].name),
                        subtitle: Text('Rp ${filteredMenuItems[index].price}'),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            var item = filteredMenuItems[index];
                            cart.add(MenuItemModel(
                              name: item.name,
                              price: item.price,
                            ));
                          },
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Silakan melakukan pencarian untuk melihat menu...',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
          if (cart.items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total: Rp ${cart.totalPrice}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(),
                            ),
                          );
                        },
                        child: Text('Proses'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          cart.removeLast();
                        },
                        child: Text('Batal'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
