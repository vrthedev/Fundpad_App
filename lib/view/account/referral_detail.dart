import 'package:flutter/material.dart';
import 'package:fundpad/model/referee.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/button_circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReferralDetail extends StatelessWidget {
  const ReferralDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.BLUE_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: COLOR.BLUE_PRIMARY,
        centerTitle: true,
        title: Text(
          "Referral Commissions",
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Text(
                    "Referral",
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
                    "Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Referee>>(
                  future: Util.accountReferees(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Referee> referees = snapshot.data!;

                      return ListView.separated(
                        itemCount: referees.length,
                        itemBuilder: (context, index) {
                          Referee referee = referees[index];

                          return BackWidget(
                            child: Row(
                              children: [
                                Text(
                                  referee.investorName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "\$" +
                                      Util.formattedCommaString(
                                          referee.amount.toStringAsFixed(2)),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  DateFormat("yyyy-MM-dd")
                                      .format(referee.createdAt),
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
          ],
        ),
      ),
    );
  }
}
