import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class ProfitsPage extends StatefulWidget {
  const ProfitsPage({Key? key}) : super(key: key);

  @override
  State<ProfitsPage> createState() => _ProfitsPageState();
}

class _ProfitsPageState extends State<ProfitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "\$46,000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: COLOR.PALE_ORANGE,
                  ),
                ),
                Text("My Balance"),
              ],
            ),
            const SizedBox(height: 16),
            DataTable(
              showCheckboxColumn: false,
              columns: const [
                DataColumn(label: Text("")),
                DataColumn(label: Text("%")),
                DataColumn(label: Text("Profits")),
              ],
              rows: [
                DataRow(
                    cells: const [
                      DataCell(Text("January")),
                      DataCell(Text("8.9%")),
                      DataCell(Text("\$ 3,700")),
                    ],
                    onSelectChanged: (v) {
                      print("Here is selected");
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
