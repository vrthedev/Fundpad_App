import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/pledge.dart';
import 'package:fundpad/model/project.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/image_header.dart';
import 'package:fundpad/view/home/pledge_page.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
            int percent =
                (project.fundRaised * 100 / project.fundTarget).round();

            String target = Util.formattedCommaString(
                project.fundTarget.toInt().toString());
            String balance = Util.formattedCommaString(
                project.fundRaised.toInt().toString());

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset("images/ic_profile.png", width: 52),
                            const SizedBox(width: 16),
                            Text(
                              Globals.currentUser!.fullname,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CircularPercentIndicator(
                          radius: 110.0,
                          lineWidth: 20.0,
                          percent: project.fundRaised / project.fundTarget,
                          center: Container(
                            width: 164,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: provider.getThemeMode() ==
                                            ThemeMode.dark
                                        ? const [
                                            Color(0xff29292B),
                                            Color(0xff1F1F21)
                                          ]
                                        : const [
                                            Color(0xffD7D8E5),
                                            Color(0xffFAFAFF)
                                          ]),
                                boxShadow: provider.getThemeMode() ==
                                        ThemeMode.dark
                                    ? [
                                        BoxShadow(
                                            offset: const Offset(0, -6.8),
                                            blurRadius: 6.8,
                                            spreadRadius: 0,
                                            color: const Color(0xff1D1E1F)
                                                .withOpacity(0.5)),
                                        BoxShadow(
                                            offset: const Offset(0, 6.8),
                                            blurRadius: 14.8,
                                            spreadRadius: 0,
                                            color: const Color(0xff141416)
                                                .withOpacity(0.6)),
                                      ]
                                    : [
                                        BoxShadow(
                                            offset: const Offset(0, -5.39),
                                            blurRadius: 5.39,
                                            spreadRadius: 0,
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                        BoxShadow(
                                            offset: const Offset(0, 5.39),
                                            blurRadius: 5.39,
                                            spreadRadius: 0,
                                            color: const Color(0xffDEDEDE)
                                                .withOpacity(0.5)),
                                      ]),
                            alignment: Alignment.center,
                            child: Text(
                              "$percent%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 48,
                                  color: COLOR.ORANGE_PRIMARY),
                            ),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: COLOR.BLUE_PRIMARY,
                          backgroundColor:
                              provider.getThemeMode() == ThemeMode.dark
                                  ? const Color(0xff0D0D0D)
                                  : const Color(0xff000000).withOpacity(0.06),
                          animation: true,
                          footer: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: provider.getThemeMode() == ThemeMode.dark
                          ? COLOR.BLACK_BACK
                          : Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () => getMyLastPledge(project),
                        child: const Text(
                          "PLEDGE",
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
                          launchUrl(Uri.parse(SOUT_OVERVIEW));
                        },
                        child: const Text(
                          "SOUTHONE OVERVIEW",
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
                          launchUrl(Uri.parse(USER_AGREE));
                        },
                        child: const Text(
                          "USER AGREEMENT",
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
                    ]),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {},
                    //         child: Container(
                    //           constraints:
                    //               const BoxConstraints(minHeight: 140),
                    //           padding: const EdgeInsets.all(16),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(16),
                    //               border:
                    //                   Border.all(color: COLOR.BLUE_PRIMARY)),
                    //           alignment: Alignment.center,
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Image.asset("images/ic_document.png"),
                    //               const SizedBox(height: 8),
                    //               const Text(
                    //                 "Contract\nAgreement",
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w600,
                    //                   fontSize: 16,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 16),
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {
                    //           getMyLastPledge(project);
                    //         },
                    //         child: Container(
                    //           constraints:
                    //               const BoxConstraints(minHeight: 140),
                    //           padding: const EdgeInsets.all(16),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(16),
                    //             border:
                    //                 Border.all(color: COLOR.ORANGE_PRIMARY),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Image.asset("images/ic_pledge.png"),
                    //               const SizedBox(height: 8),
                    //               const Text(
                    //                 "Pledge\nMoney",
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w600,
                    //                   fontSize: 16,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  )
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

  void getMyLastPledge(Project project) async {
    try {
      Pledge pledge = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          Util.getMyLastPledge(),
        ),
      );

      if (pledge.transaction.isNotEmpty) {
        pledge = Pledge.fromJson({});
      }

      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => ImageHeader(
              light: "images/pledge.png",
              dark: "images/pledge.png",
              title: "Pledge",
              child: PledgePage(
                project: project,
                pledge: pledge,
              )),
        ),
      );
    } catch (e) {
      showToast(e.toString());
    }
  }
}
