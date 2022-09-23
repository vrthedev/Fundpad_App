import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundpad/model/pledge.dart';
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
  const PledgePage({Key? key, required this.project, required this.pledge})
      : super(key: key);

  final Project project;
  final Pledge pledge;

  @override
  State<PledgePage> createState() => _PledgePageState();
}

class _PledgePageState extends State<PledgePage> {
  final _amountFormKey = GlobalKey<FormState>();
  final _txFormKey = GlobalKey<FormState>();
  final _walletFormKey = GlobalKey<FormState>();
  final teWallet = TextEditingController(text: Globals.currentUser!.wallet);
  final teAmount = TextEditingController();
  final teTransaction = TextEditingController();

  late Pledge pledge;

  @override
  void initState() {
    super.initState();

    pledge = widget.pledge;
    if (pledge.amount > 0) {
      teAmount.text = pledge.amount.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Container(
      width: double.infinity,
      // height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          color: provider.getThemeMode() == ThemeMode.dark
              ? const Color(0xff0F0F0F)
              : const Color(0xffFBFCFF)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Pledge",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 8),
            // pledge.id.isEmpty ? _amountColumn() : _transactionColumn(provider),
            _amountColumn(),
            const SizedBox(height: 24),
            _transactionColumn(provider),
          ],
        ),
      ),
    );
  }

  Widget _amountColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          "How much would you like to Pledge? Min \$500",
          style: TextStyle(color: COLOR.TEXT_HINT, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Form(
          key: _amountFormKey,
          child: TextFormField(
            controller: teAmount,
            enabled: pledge.id.isEmpty,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                return 'Please enter amount';
              } else if (!Util.isNumeric(value)) {
                return "Invalid amount";
              } else {
                double v = double.tryParse(value) ?? 0;
                if (v < 500) {
                  return "It's too small";
                }
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 8),
        // Center(
        //   child: Text(
        //     "All Payments in USDT  TRC20 Only".toUpperCase(),
        //     style: const TextStyle(
        //       color: COLOR.TEXT_RED,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 15,
        //     ),
        //   ),
        // ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: pledge.id.isEmpty
                ? () {
                    if (_amountFormKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        'investor_id': Globals.currentUser!.id,
                        'amount': teAmount.text,
                      };

                      upsertPledge(data);
                      Util.mailDeposit();
                    }
                  }
                : null,
            child: const Text(
              "Submit",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(103, 48),
              primary: const Color(0xff0E1446),
            ),
          ),
        ),
      ],
    );
  }

  Widget _transactionColumn(HomeProvider provider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   "Please deposit it to the following Wallet Address only.",
        //   style: TextStyle(color: COLOR.TEXT_HINT, fontSize: 15),
        // ),
        // const SizedBox(height: 16),
        // Align(
        //   alignment: Alignment.center,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       QrImage(
        //         data: widget.project.depositAddress,
        //         version: QrVersions.auto,
        //         size: 80,
        //         eyeStyle: QrEyeStyle(
        //             eyeShape: QrEyeShape.square,
        //             color: provider.getThemeMode() == ThemeMode.dark
        //                 ? Colors.white
        //                 : Colors.black),
        //         dataModuleStyle: QrDataModuleStyle(
        //             dataModuleShape: QrDataModuleShape.square,
        //             color: provider.getThemeMode() == ThemeMode.dark
        //                 ? Colors.white
        //                 : Colors.black),
        //       ),
        //       Row(mainAxisSize: MainAxisSize.min, children: [
        //         Text(
        //           widget.project.depositAddress,
        //           style: const TextStyle(
        //               letterSpacing: 1.05,
        //               fontSize: 16,
        //               fontWeight: FontWeight.w500),
        //         ),
        //         IconButton(
        //           onPressed: () {
        //             Clipboard.setData(
        //                 ClipboardData(text: widget.project.depositAddress));
        //           },
        //           icon: const Icon(Icons.copy),
        //         ),
        //       ])
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 16),
        const Center(
          child: Text(
            "Once you submit a pledge amount, we will email the project's wallet address to your registered email ID. Please confirm the last 6 digits on the wallet address are: uCgHkN",
            style: TextStyle(
              color: COLOR.TEXT_RED,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Once payment is sent pledge submit your TX ID below",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "(Without this we cannot verify your payment)".toUpperCase(),
            style: const TextStyle(
              color: COLOR.TEXT_RED,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Form(
          key: _txFormKey,
          child: TextFormField(
            controller: teTransaction,
            decoration: InputDecoration(
              hintText: 'TXID',
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
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: pledge.id.isEmpty
                ? null
                : () async {
                    if (_txFormKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        '_id': pledge.id,
                        'transaction': teTransaction.text,
                        'investor_id': Globals.currentUser!.id,
                        'amount': teAmount.text,
                      };

                      print(data);

                      bool isSuccess = await upsertPledge(data);
                      if (isSuccess) {
                        teAmount.clear();
                        teTransaction.clear();
                        setState(() {
                          pledge = Pledge.fromJson({});
                        });
                      }
                    }
                  },
            child: const Text(
              "Submit",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(103, 48),
              primary: const Color(0xff0E1446),
            ),
          ),
        ),
        // const SizedBox(height: 24),
        // const Text(
        //   "Please supply a USDT TRC20 Receipient Wallet Address",
        //   style: TextStyle(fontWeight: FontWeight.w600),
        // ),
        // const SizedBox(height: 8),
        // Form(
        //   key: _walletFormKey,
        //   child: TextFormField(
        //     controller: teWallet,
        //     decoration: InputDecoration(
        //       hintText: 'Wallet address',
        //       hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16.0),
        //         borderSide: const BorderSide(
        //           color: COLOR.BLUE_SECONDARY,
        //           width: 1.5,
        //         ),
        //       ),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16),
        //         borderSide: const BorderSide(
        //           color: COLOR.GRAY_BORDER,
        //           width: 1.5,
        //         ),
        //       ),
        //     ),
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return 'Please enter Wallet address';
        //       }
        //       return null;
        //     },
        //   ),
        // ),
        // const SizedBox(height: 16),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       if (_walletFormKey.currentState!.validate()) {
        //         updateWallet();
        //       }
        //     },
        //     child: const Text(
        //       "Submit",
        //       style: TextStyle(
        //         fontSize: 16,
        //         color: Colors.white,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       minimumSize: const Size(103, 48),
        //       primary: const Color(0xff0E1446),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Future<bool> upsertPledge(Map<String, dynamic> data) async {
    FocusScope.of(context).unfocus();

    try {
      String result = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          Util.upsertPledge(data),
        ),
      );

      setState(() {
        pledge.id = result;
      });

      return true;
    } catch (e) {
      showToast(e.toString());
      return false;
    }
  }

  void updateWallet() async {
    FocusScope.of(context).unfocus();

    Map<String, dynamic> data = {"wallet": teWallet.text};

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.updateProfile(data),
      ),
    );

    if (result == "Success") {
      Globals.currentUser!.wallet = teWallet.text;
    } else {
      showToast(result);
    }
  }
}
