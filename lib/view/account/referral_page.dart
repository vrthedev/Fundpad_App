import 'package:flutter/material.dart';
import 'package:fundpad/model/referee.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/back_widget.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({Key? key, required this.sum}) : super(key: key);

  final double sum;

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
                    "Total Referral Capital To Date",
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
                      "Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        "Capital",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        "total Profit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Referee>>(
                future: Util.accountReferees(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Referee> referees = snapshot.data!;

                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: referees.length,
                      itemBuilder: (context, index) {
                        Referee referee = referees[index];

                        return BackWidget(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  referee.fullname,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    "\$" +
                                        Util.formattedCommaString(referee
                                            .confirmedAmount
                                            .toStringAsFixed(2)),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    "\$" +
                                        Util.formattedCommaString(referee
                                            .investorPayouts
                                            .toStringAsFixed(2)),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
