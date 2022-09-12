import 'package:flutter/material.dart';
import 'package:fundpad/model/payout.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: COLOR.ORANGE_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: COLOR.ORANGE_PRIMARY,
        centerTitle: true,
        title: Text(
          "Profits",
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: COLOR.ORANGE_PRIMARY)),
                child: Row(
                  children: [
                    Image.asset("images/ic_income.png"),
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
                            "My Balance",
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
                    Expanded(
                      child: Text(
                        "Month",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Profit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          payout.profitName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "\$" +
                              Util.formattedCommaString(
                                  payout.amount.toStringAsFixed(2)),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          payout.percentage.toString() + "%",
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
}
