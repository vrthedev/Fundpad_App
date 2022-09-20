import 'package:flutter/material.dart';
import 'package:fundpad/model/referee.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:intl/intl.dart';

class ReferralTab extends StatefulWidget {
  const ReferralTab({Key? key, required this.dataMap}) : super(key: key);

  final Map<String, List<Referee>> dataMap;

  @override
  State<ReferralTab> createState() => _ReferralTabState();
}

class _ReferralTabState extends State<ReferralTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: widget.dataMap.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.dataMap.length,
            child: TabBar(
              tabs: widget.dataMap.keys.map(
                (e) {
                  bool isSelected =
                      widget.dataMap.keys.elementAt(_tabController.index) == e;
                  return Tab(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: isSelected
                                ? COLOR.BLUE_PRIMARY
                                : Colors.transparent),
                      ),
                      child: Text(
                        e,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: isSelected ? 18 : 14,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
              controller: _tabController,
              indicatorColor: Colors.transparent,
              indicatorWeight: 0.1,
              isScrollable: true,
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
              // Spacer(),
              // Text(
              //   "Date",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.dataMap.values.map((e) {
              //Unique inverstor ID List
              List<String> ids = e.map((e) => e.investorID).toSet().toList();
              List<Map<String, dynamic>> dataList = ids.map((id) {
                List<Referee> refers =
                    e.where((e) => e.investorID == id).toList();

                double amount = 0;
                String name = "";
                for (var element in refers) {
                  amount += element.amount;
                  name = element.investorName;
                }

                Map<String, dynamic> data = {"name": name, "amount": amount};
                return data;
              }).toList();

              return ListView.separated(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = dataList[index];

                  return BackWidget(
                    child: Row(
                      children: [
                        Text(
                          data["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$" +
                              Util.formattedCommaString(
                                  data["amount"].toStringAsFixed(2)),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        // const Spacer(),
                        // Text(
                        //   DateFormat.yMd().format(referee.createdAt),
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 13,
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
