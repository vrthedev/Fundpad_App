import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/account_info.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/account/commission_page.dart';
import 'package:fundpad/view/account/profits_page.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/button_circle.dart';
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

            int pledgesCount =
                account.pledges.where((element) => element.status == 1).length;

            return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const ButtonCircle(
                          child: Icon(
                            Icons.account_balance_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$pledgesCount Pledges",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                "Total Balance",
                                style: TextStyle(
                                  letterSpacing: 1.05,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "\$" +
                              Util.formattedCommaString(
                                  account.pledgesSum.toStringAsFixed(2)),
                          style: const TextStyle(
                            letterSpacing: 1.05,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BackWidget(
                            callback: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => ProfitsPage(
                                    sum: account.investorSum,
                                    payouts: account.investorPayouts,
                                  ),
                                ),
                              );
                            },
                            padding: 8,
                            child: Row(
                              children: [
                                ButtonCircle(
                                  gradient: const [
                                    COLOR.ORANGE_LIGHT,
                                    COLOR.ORANGE_DARK
                                  ],
                                  shadow: COLOR.ORANGE_DARK.withOpacity(0.25),
                                  child: const Icon(
                                    Icons.storefront_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Profits",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "\$" +
                                            Util.formattedCommaString(account
                                                .investorSum
                                                .toStringAsFixed(2)),
                                        style: const TextStyle(
                                          letterSpacing: 1.05,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BackWidget(
                            callback: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => CommissionPage(
                                    sum: account.referralSum,
                                    payouts: account.referralPayouts,
                                  ),
                                ),
                              );
                            },
                            padding: 8,
                            child: Row(
                              children: [
                                const ButtonCircle(
                                  child: Icon(
                                    Icons.wallet_giftcard,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Commissions",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "\$" +
                                            Util.formattedCommaString(account
                                                .referralSum
                                                .toStringAsFixed(2)),
                                        style: const TextStyle(
                                          letterSpacing: 1.05,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ReferralInfo(code: Globals.currentUser!.referralCode),
                  ],
                ));
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
