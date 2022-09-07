import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/payout.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/account/referral_detail.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/button_circle.dart';

class CommissionPage extends StatefulWidget {
  const CommissionPage({Key? key, required this.sum, required this.payouts})
      : super(key: key);

  final double sum;
  final List<Payout> payouts;

  @override
  State<CommissionPage> createState() => _CommissionPageState();
}

class _CommissionPageState extends State<CommissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.BLUE_LIGHT,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: COLOR.BLUE_LIGHT,
        title: const Text(
          "Commissions",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: goDetail,
            icon: const Icon(Icons.details, color: Colors.white),
          )
        ],
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
          child: Column(
            children: [
              BackWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Commissions",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "\$" +
                          Util.formattedCommaString(
                              widget.sum.toStringAsFixed(2)),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: COLOR.BLUE_DARK,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                itemCount: widget.payouts.length,
                itemBuilder: (context, index) {
                  Payout payout = widget.payouts[index];

                  return ListTile(
                    leading: const ButtonCircle(
                      padding: 8,
                      child: Icon(
                        Icons.wallet_giftcard_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    title: Text(
                      payout.profitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      payout.percentage.toString() + "%",
                      style: const TextStyle(
                        color: COLOR.TEXT_HINT,
                      ),
                    ),
                    trailing: Text(
                      "\$" +
                          Util.formattedCommaString(
                              payout.amount.toStringAsFixed(2)),
                      style: const TextStyle(
                        color: COLOR.BLUE_DARK,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goDetail() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => const ReferralDetail(),
      ),
    );
  }
}
