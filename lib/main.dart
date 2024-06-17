import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kasir_app/screens/ReportPage.dart';
import 'package:kasir_app/models/CartModel.dart';
import 'package:kasir_app/models/SalesReportModel.dart';
import 'package:kasir_app/screens/MenuPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => SalesReportModel()),
      ],
      child: MaterialApp(
        title: 'Mesin Kasir Mie Ayam',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesin Kasir Mie Ayam'),
        backgroundColor: Colors.blue,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MenuPage(),
          ReportPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Laporan',
          ),
        ],
        currentIndex: _tabController.index,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          _tabController.animateTo(index);
        },
      ),
    );
  }
}
