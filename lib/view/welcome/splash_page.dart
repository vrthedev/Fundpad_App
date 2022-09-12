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
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}
