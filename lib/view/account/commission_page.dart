import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class CommissionPage extends StatefulWidget {
  const CommissionPage({Key? key}) : super(key: key);

  @override
  State<CommissionPage> createState() => _CommissionPageState();
}

class _CommissionPageState extends State<CommissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  "\$41,000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: COLOR.PALE_ORANGE,
                  ),
                ),
                Text("Referal Balance"),
              ],
            ),
            const SizedBox(height: 16),
            FittedBox(
              child: DataTable(
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("%")),
                  DataColumn(label: Text("Total \nProfits")),
                  DataColumn(label: Text("Total \nCommissions")),
                ],
                rows: [
                  DataRow(
                      cells: const [
                        DataCell(Text("January")),
                        DataCell(Text("2023")),
                        DataCell(Text("8.9%")),
                        DataCell(Text("\$ 3,700")),
                        DataCell(Text("\$ 656")),
                      ],
                      onSelectChanged: (v) {
                        print("Here is selected");
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
