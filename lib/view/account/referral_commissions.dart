import 'package:flutter/material.dart';
import 'package:fundpad/model/referee.dart';
import 'package:fundpad/model/referral.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/referral_tab.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ReferralCommissions extends StatefulWidget {
  const ReferralCommissions({Key? key, this.date}) : super(key: key);

  final DateTime? date;

  @override
  State<ReferralCommissions> createState() => _ReferralCommissionsState();
}

class _ReferralCommissionsState extends State<ReferralCommissions> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();

    _currentDate = widget.date ?? DateTime.now();
  }

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

              return Column(
                children: [
                  _monthButton(),
                  _header(),
                  Expanded(child: _dataListView(referees)),
                ],
              );
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

  Widget _monthButton() {
    return OutlinedButton(
      onPressed: () async {
        final selected = await showMonthYearPicker(
          context: context,
          initialDate: _currentDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );

        if (selected != null) {
          setState(() {
            _currentDate = selected;
          });
        }
      },
      child: Text(
        DateFormat.yMMM().format(_currentDate),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        primary: COLOR.BLUE_PRIMARY,
        side: const BorderSide(color: COLOR.BLUE_PRIMARY),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              "Referrals",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Profit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Commission",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataListView(List<Referral> allList) {
    List<Referral> referrals = allList.where((e) {
      return e.year == _currentDate.year && e.month == _currentDate.month;
    }).toList();

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: referrals.length,
      itemBuilder: (context, index) {
        Referral referral = referrals[index];

        return BackWidget(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      referral.appUserName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "\$" +
                          Util.formattedCommaString(
                              referral.baseAmount.toStringAsFixed(2)),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: COLOR.BLUE_PRIMARY),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "\$" +
                      Util.formattedCommaString(
                          referral.amount.toStringAsFixed(2)),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  "\$" +
                      Util.formattedCommaString(
                          (referral.amount / 5).toStringAsFixed(2)),
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
    );
  }
}
