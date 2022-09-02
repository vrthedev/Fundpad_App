import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class PledgePage extends StatefulWidget {
  const PledgePage({Key? key}) : super(key: key);

  @override
  State<PledgePage> createState() => _PledgePageState();
}

class _PledgePageState extends State<PledgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "MY PLEDGE \$ 2,500,000",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              "MIN PLEDGE \$ 1,000",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("All payments in USDT TRC20 only"),
                    const Text(
                        "Please deposit it to the following Wallet Address only."),
                    TextFormField(),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("SUBMIT"),
                        style: ElevatedButton.styleFrom(
                          primary: COLOR.LIGHT_BLUE,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "Once payment is sent pledge submit your TX ID Below"),
                    TextFormField(),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("SUBMIT"),
                        style: ElevatedButton.styleFrom(
                          primary: COLOR.LIGHT_BLUE,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "Please supply a USDT TRC20 Receipient Wallet Address"),
                    TextFormField(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("SUBMIT"),
                        style: ElevatedButton.styleFrom(
                          primary: COLOR.LIGHT_BLUE,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
