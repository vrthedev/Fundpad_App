import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/view/welcome/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.SPLASH_BACKGROUND,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset('images/logo.png'),
          const SizedBox(height: 40),
          Image.asset(
            'images/logol1.png',
            height: MediaQuery.of(context).size.width / 2,
          ),
        ]),
      ),
    );
  }
}
