import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kasir_app/models/SalesReportModel.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var salesReport = Provider.of<SalesReportModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Penjualan'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: salesReport.reports.length,
        itemBuilder: (context, index) {
          final report = salesReport.reports[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nomor Pesanan: ${index + 1}'),
                  SizedBox(height: 8.0),
                  Text('Tanggal dan Jam: ${report.dateTime}'),
                  SizedBox(height: 8.0),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Qty'),
                          Expanded(
                            child: Text(
                              'Nama Menu',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text('Amt'),
                        ],
                      ),
                      Divider(),
                      ...List.generate(
                        report.items.length,
                        (i) {
                          final item = report.items[i];
                          final qty = report.quantities[i];
                          final amt = item.price * qty;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$qty'),
                                Expanded(
                                  child: Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text('Rp $amt'),
                              ],
                            ),
                          );
                        },
                      ),
                      Divider(),
                      SizedBox(height: 8.0),
                      Text('TOTAL: Rp ${report.totalPrice}'),
                      Text('Tunai: Rp ${report.totalPricePaid}'),
                      Text('Kembalian: Rp ${report.changeAmount}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
