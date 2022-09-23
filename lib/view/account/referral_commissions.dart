import 'package:flutter/material.dart';
import 'package:fundpad/model/referee.dart';
import 'package:fundpad/model/referral.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/referral_tab.dart';
import 'package:intl/intl.dart';

class ReferralCommissions extends StatelessWidget {
  const ReferralCommissions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: FutureBuilder<List<Referral>>(
          future: Util.accountReferrals(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Referral> referees = snapshot.data!;

              DateFormat formatter = DateFormat.yMMM();
              Map<String, List<Referral>> dataMap = {};
              String key = "";
              List<Referral> data = [];

              for (var e in referees) {
                if (formatter.format(e.createdAt) != key) {
                  if (key.isNotEmpty) {
                    dataMap[key] = data;
                  }

                  key = formatter.format(e.createdAt);
                  data.clear();
                }
                data.add(e);
              }

              if (key.isNotEmpty) {
                dataMap[key] = data;
              }

              return ReferralTab(dataMap: dataMap);
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
