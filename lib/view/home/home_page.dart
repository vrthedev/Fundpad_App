import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/project.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/home/pledge_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return FutureBuilder<Project>(
        future: Util.getProject(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Project project = snapshot.data!;
            if (project.isActive) {
              int percent = project.fundRaised * 100 ~/ project.fundTarget;

              String target = Util.formattedCommaString(
                  project.fundTarget.toStringAsFixed(2));
              String balance = Util.formattedCommaString(
                  project.fundRaised.toStringAsFixed(2));

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 20.0,
                      percent: project.fundRaised / project.fundTarget,
                      center: Text(
                        "$percent%",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 48,
                            color: COLOR.ORANGE_PRIMARY),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: COLOR.BLUE_PRIMARY,
                      animation: true,
                      footer: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "\$" + target,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                              const Text(
                                "Target",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: COLOR.TEXT_HINT,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "\$" + balance,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                              const Text(
                                "Balance",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: COLOR.TEXT_HINT,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: provider.getThemeMode() == ThemeMode.dark
                          ? COLOR.BLACK_BACK
                          : Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 140),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: COLOR.BLUE_PRIMARY)),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("images/ic_document.png"),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Contract\nAgreement",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      PledgePage(project: project),
                                ),
                              );
                            },
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 140),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: COLOR.ORANGE_PRIMARY),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("images/ic_pledge.png"),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Pledge\nMoney",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
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
