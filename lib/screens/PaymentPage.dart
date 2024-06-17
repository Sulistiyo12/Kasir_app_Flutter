import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kasir_app/models/CartModel.dart';
import 'package:kasir_app/models/SalesReportModel.dart';
import 'package:kasir_app/models/MenuItemModel.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _amountPaidController = TextEditingController();
  String _change = '';
  late List<MenuItemModel> _orderedItems; // Menyimpan riwayat pesanan

  @override
  void initState() {
    _orderedItems = List.from(
      Provider.of<CartModel>(context, listen: false).items,
    ); // Mengisi riwayat pesanan
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    void _calculateChange() {
      int amountPaid = int.tryParse(_amountPaidController.text) ?? 0;
      int change = amountPaid - cart.totalPrice;

      setState(() {
        if (change >= 0) {
          _change = 'Kembalian: Rp $change';
        } else {
          _change = 'Uang yang dibayarkan kurang!';
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total: Rp ${cart.totalPrice}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountPaidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Uang yang Dibayarkan',
              ),
              onChanged: (value) {
                _calculateChange();
              },
            ),
            SizedBox(height: 20),
            Text(
              _change,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_change != 'Uang yang dibayarkan kurang!') {
                  Provider.of<SalesReportModel>(context, listen: false)
                      .addReport(
                    _orderedItems, // Menggunakan riwayat pesanan
                    _orderedItems.map((item) => item.quantity).toList(),
                    cart.totalPrice,
                    int.parse(_amountPaidController.text),
                    int.parse(_amountPaidController.text) - cart.totalPrice,
                  );

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Pembayaran Berhasil'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Metode Pembayaran: Tunai'),
                          Text('Total: Rp ${cart.totalPrice}'),
                          Text(
                              'Jumlah Uang Bayar: Rp ${_amountPaidController.text}'),
                          Text(_change),
                          SizedBox(height: 16),
                          Text('Daftar Makanan:'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _orderedItems
                                .map((item) => Text(
                                    '${item.name}: ${item.quantity} porsi'))
                                .toList(),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop(); // Kembali ke MenuPage
                            Provider.of<CartModel>(context, listen: false)
                                .clear(); // Membersihkan keranjang
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Konfirmasi Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
