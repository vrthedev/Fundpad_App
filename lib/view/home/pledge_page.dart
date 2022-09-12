import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundpad/model/project.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PledgePage extends StatefulWidget {
  const PledgePage({Key? key, required this.project}) : super(key: key);

  final Project project;

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
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xff0E1446),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff0E1446),
        centerTitle: true,
        title: Text(
          "Pledge",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            color: provider.getThemeMode() == ThemeMode.dark
                ? const Color(0xff0F0F0F)
                : const Color(0xffFBFCFF)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Pledge",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(height: 4),
                const Text(
                  "How much would you like to Pledge? Min \$500",
                  style: TextStyle(color: COLOR.TEXT_HINT),
                ),
                const SizedBox(height: 4),
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
                        data: widget.project.depositAddress,
                        version: QrVersions.auto,
                        size: 80,
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          widget.project.depositAddress,
                          style: const TextStyle(
                              letterSpacing: 1.05,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: widget.project.depositAddress));
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
                TextFormField(
                  controller: teTransaction,
                  decoration: InputDecoration(
                    hintText: 'Transaction ID',
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: COLOR.BLUE_SECONDARY,
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: COLOR.GRAY_BORDER,
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Transaction ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: teAmount,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: COLOR.BLUE_SECONDARY,
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: COLOR.GRAY_BORDER,
                        width: 1.5,
                      ),
                    ),
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
                const SizedBox(height: 16),
                const Text(
                  "Please supply a USDT TRC20 Receipient Wallet Address",
                  style: TextStyle(color: COLOR.TEXT_HINT),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: teWallet,
                  decoration: InputDecoration(
                    hintText: 'Wallet address',
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: COLOR.BLUE_SECONDARY,
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: COLOR.GRAY_BORDER,
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Wallet address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createPledge();
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 64),
                    primary: const Color(0xff0E1446),
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
