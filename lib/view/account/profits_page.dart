import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/payout.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/account/referral_detail.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/button_circle.dart';

class ProfitsPage extends StatefulWidget {
  const ProfitsPage({Key? key, required this.sum, required this.payouts})
      : super(key: key);

  final double sum;
  final List<Payout> payouts;

  @override
  State<ProfitsPage> createState() => _ProfitsPageState();
}

class _ProfitsPageState extends State<ProfitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.BLUE_LIGHT,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: COLOR.BLUE_LIGHT,
        title: const Text(
          "Profits",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BackWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Profits",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "\$" +
                          Util.formattedCommaString(
                              widget.sum.toStringAsFixed(2)),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: COLOR.ORANGE_DARK,
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
                    onTap: () {},
                    leading: ButtonCircle(
                      gradient: const [COLOR.ORANGE_LIGHT, COLOR.ORANGE_DARK],
                      shadow: COLOR.ORANGE_DARK.withOpacity(0.25),
                      padding: 8,
                      child: const Icon(
                        Icons.storefront_outlined,
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
                        color: COLOR.ORANGE_DARK,
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
}
