import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/payout.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/account/referral_commissions.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/image_header.dart';
import 'package:intl/intl.dart';

class CommissionPage extends StatelessWidget {
  const CommissionPage({Key? key, required this.sum, required this.payouts})
      : super(key: key);

  final double sum;
  final List<Payout> payouts;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: COLOR.BLUE_PRIMARY)),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("images/ic_referral.png"),
                      const SizedBox(width: 24),
                      Text(
                        "\$" +
                            Util.formattedCommaString(sum.toStringAsFixed(2)),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Total Commissions To Date",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Month",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Profit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Commissions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: payouts.length,
              itemBuilder: (context, index) {
                Payout payout = payouts[index];

                return BackWidget(
                  callback: () {
                    DateTime date = DateTime(payout.year, payout.month, 10);
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => ImageHeader(
                            light: "images/purple_light.png",
                            dark: "images/purple_dark.png",
                            title: "Referrals / Commissions",
                            child: ReferralCommissions(date: date)),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(
                              DateFormat('MMMM')
                                  .format(DateTime(0, payout.month)),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              payout.year.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          payout.percentage.toString() + "%",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "\$" +
                              Util.formattedCommaString(
                                  (payout.amount * 5).toStringAsFixed(2)),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "\$" +
                              Util.formattedCommaString(
                                  payout.amount.toStringAsFixed(2)),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
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
    );
  }
}
