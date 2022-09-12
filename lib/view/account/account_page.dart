import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/account_info.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/account/commission_page.dart';
import 'package:fundpad/view/account/profits_page.dart';
import 'package:fundpad/view/account/referral_detail.dart';
import 'package:fundpad/widget/referral_info.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AccountInfo>(
        future: Util.getAccountInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AccountInfo account = snapshot.data!;

            // int pledgesCount =
            //     account.pledges.where((element) => element.status == 1).length;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 140),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: COLOR.BLUE_PRIMARY),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("images/ic_income.png"),
                                    const SizedBox(height: 8),
                                    Text(
                                      "\$" +
                                          Util.formattedCommaString(account
                                              .pledgesSum
                                              .toStringAsFixed(2)),
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      "My Balance",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 140),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: COLOR.ORANGE_PRIMARY),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("images/ic_referral.png"),
                                    const SizedBox(height: 8),
                                    Text(
                                      "\$" +
                                          Util.formattedCommaString(account
                                              .referralSum
                                              .toStringAsFixed(2)),
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      "Referral Balance",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => ProfitsPage(
                                  sum: account.investorSum,
                                  payouts: account.investorPayouts,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Profits",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: const Size(double.infinity, 60),
                            primary: COLOR.ORANGE_PRIMARY,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => CommissionPage(
                                  sum: account.referralSum,
                                  payouts: account.referralPayouts,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Monthly Commissions",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: const Size(double.infinity, 60),
                            primary: COLOR.BLUE_PRIMARY,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => const ReferralDetail(),
                              ),
                            );
                          },
                          child: const Text(
                            "Referral Commissions",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: const Size(double.infinity, 60),
                            primary: COLOR.BLUE_PRIMARY,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReferralInfo(code: Globals.currentUser!.referralCode),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container();
            // return Padding(
            //   padding: const EdgeInsets.only(top: 50),
            //   child: Center(
            //     child: Text(snapshot.error!.toString()),
            //   ),
            // );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
