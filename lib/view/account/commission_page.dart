import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/payout.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/account/referral_detail.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/button_circle.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: COLOR.BLUE_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: COLOR.BLUE_PRIMARY,
        centerTitle: true,
        title: Text(
          "Monthly Commissions",
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
            color: Theme.of(context).scaffoldBackgroundColor),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: COLOR.BLUE_PRIMARY)),
                child: Row(
                  children: [
                    Image.asset("images/ic_referral.png"),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "\$" +
                                Util.formattedCommaString(
                                    widget.sum.toStringAsFixed(2)),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                          const Text(
                            "Referral Balance",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Text(
                      "Month",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Commissions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                itemCount: widget.payouts.length,
                itemBuilder: (context, index) {
                  Payout payout = widget.payouts[index];

                  return BackWidget(
                    child: Row(
                      children: [
                        Text(
                          payout.profitName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$" +
                              Util.formattedCommaString(
                                  payout.baseAmount.toStringAsFixed(2)),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          payout.percentage.toString() + "%",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$" +
                              Util.formattedCommaString(
                                  payout.amount.toStringAsFixed(2)),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
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
