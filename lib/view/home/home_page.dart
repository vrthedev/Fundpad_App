import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/model/project.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/home/pledge_page.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/button_circle.dart';
import 'package:fundpad/widget/button_round.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Image.asset(
            "images/logo.png",
            width: 160,
          ),
          const Spacer(),
          FutureBuilder<Project>(
              future: Util.getProject(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Project project = snapshot.data!;
                  if (project.isActive) {
                    int percent =
                        project.fundRaised * 100 ~/ project.fundTarget;

                    String target = Util.formattedCommaString(
                        project.fundTarget.toStringAsFixed(2));

                    return BackWidget(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\$" + target,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: double.infinity,
                                height: 20,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value:
                                        project.fundRaised / project.fundTarget,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            COLOR.BLUE_LIGHT),
                                    backgroundColor: const Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                              ButtonCircle(
                                child: Text(
                                  percent.toString() + "%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
              }),
          const Spacer(),
          ButtonRound(
            callback: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const PledgePage(),
                ),
              );
            },
            child: const Text(
              "Pledge",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.05,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ButtonRound(
            callback: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const PledgePage(),
                ),
              );
            },
            child: const Text(
              "Contact Agreement",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.05,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
