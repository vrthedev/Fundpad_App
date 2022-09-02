import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/view/account/commission_page.dart';
import 'package:fundpad/view/account/profits_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
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
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
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
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const ProfitsPage()),
                );
              },
              child: const Text("PROFITS"),
              style: ElevatedButton.styleFrom(
                primary: COLOR.LIGHT_BLUE,
                minimumSize: const Size(200, 40),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const CommissionPage(),
                  ),
                );
              },
              child: const Text("Referals / Commisions"),
              style: ElevatedButton.styleFrom(
                primary: COLOR.LIGHT_BLUE,
                minimumSize: const Size(200, 40),
              ),
            ),
            const Spacer(),
            Image.asset("images/logo.png", width: 200),
            const Text("Here is additional description"),
          ],
        ));
  }
}
