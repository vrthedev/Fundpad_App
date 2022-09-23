import 'package:flutter/material.dart';
import 'package:fundpad/model/referral.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/back_widget.dart';

class ReferralTab extends StatefulWidget {
  const ReferralTab({Key? key, required this.dataMap}) : super(key: key);

  final Map<String, List<Referral>> dataMap;

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
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.dataMap.values.map((e) {
              //Unique inverstor ID List

              return ListView.separated(
                itemCount: e.length,
                itemBuilder: (context, index) {
                  Referral referral = e[index];

                  return BackWidget(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                referral.fullname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "\$" +
                                    Util.formattedCommaString(referral
                                        .confirmedAmount
                                        .toStringAsFixed(2)),
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
                                Util.formattedCommaString(referral
                                    .investorPayouts
                                    .toStringAsFixed(2)),
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
                                    referral.commissions.toStringAsFixed(2)),
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
            }).toList(),
          ),
        )
      ],
    );
  }
}
