import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/border_round.dart';
import 'package:fundpad/widget/button_round.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PledgePage extends StatefulWidget {
  const PledgePage({Key? key}) : super(key: key);

  @override
  State<PledgePage> createState() => _PledgePageState();
}

class _PledgePageState extends State<PledgePage> {
  final _formKey = GlobalKey<FormState>();
  final teWallet = TextEditingController(text: Globals.currentUser!.wallet);
  final teAmount = TextEditingController();
  final teTransaction = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.BLUE_LIGHT,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: COLOR.BLUE_LIGHT,
        title: const Text(
          "Pledge",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "All payments in USDT TRC20 only",
                  style: TextStyle(color: COLOR.TEXT_HINT),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Please deposit it to the following Wallet Address only.",
                  style: TextStyle(color: COLOR.TEXT_HINT),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrImage(
                        data: Globals.currentUser!.referralCode,
                        version: QrVersions.auto,
                        size: 160,
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          Globals.currentUser!.referralCode,
                          style: const TextStyle(
                              letterSpacing: 1.05,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: Globals.currentUser!.referralCode));
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ])
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Once payment is sent pledge submit your TX ID and amout Below",
                  style: TextStyle(color: COLOR.TEXT_HINT),
                ),
                const SizedBox(height: 8),
                BorderRound(
                  horizontal: 16,
                  vertical: 2,
                  child: TextFormField(
                    controller: teTransaction,
                    decoration: const InputDecoration(
                      hintText: 'Transaction ID',
                      hintStyle: TextStyle(color: COLOR.TEXT_HINT),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Transaction ID';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BorderRound(
                  horizontal: 16,
                  vertical: 2,
                  child: TextFormField(
                    controller: teAmount,
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      hintStyle: TextStyle(color: COLOR.TEXT_HINT),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Transaction ID';
                      } else if (!Util.isNumeric(value)) {
                        return "Invalid amount";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Please supply a USDT TRC20 Receipient Wallet Address",
                  style: TextStyle(color: COLOR.TEXT_HINT),
                ),
                const SizedBox(height: 8),
                BorderRound(
                  horizontal: 16,
                  vertical: 2,
                  child: TextFormField(
                    controller: teWallet,
                    decoration: const InputDecoration(
                      hintText: 'Wallet address',
                      hintStyle: TextStyle(color: COLOR.TEXT_HINT),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Wallet address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ButtonRound(
                  callback: () {
                    if (_formKey.currentState!.validate()) {
                      createPledge();
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      letterSpacing: 1.05,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createPledge() async {
    FocusScope.of(context).unfocus();

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.createPledge(teTransaction.text, teAmount.text, teWallet.text),
      ),
    );

    if (result == "Success") {
      showToast("Your request is submitted successfully");
      Navigator.of(context).pop();
    } else {
      showToast(result);
    }
  }
}
