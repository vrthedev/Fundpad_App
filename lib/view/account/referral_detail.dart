import 'package:flutter/material.dart';
import 'package:fundpad/model/referee.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/button_circle.dart';
import 'package:intl/intl.dart';

class ReferralDetail extends StatelessWidget {
  const ReferralDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.BLUE_LIGHT,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: COLOR.BLUE_LIGHT,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: FutureBuilder<List<Referee>>(
            future: Util.accountReferees(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Referee> referees = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: referees.length,
                  itemBuilder: (context, index) {
                    Referee referee = referees[index];

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
                        referee.investorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat("MM/dd HH:mm").format(referee.createdAt),
                        style: const TextStyle(
                          color: COLOR.TEXT_HINT,
                        ),
                      ),
                      trailing: Text(
                        "\$" +
                            Util.formattedCommaString(
                                referee.amount.toStringAsFixed(2)),
                        style: const TextStyle(
                          color: COLOR.BLUE_DARK,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
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
            }),
      ),
    );
  }
}
