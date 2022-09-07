// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String BASE_URL = "http://167.99.224.239:8000/api";
// const String BASE_URL = "http://10.10.11.153:8000";

class COLOR {
  static const Color TEXT_HINT = Color(0xff7c7c7c);
  static const Color BORDER_LIGHT = Color(0xffe8e8e8);
  static const Color BACK_LIGHT = Color(0xfff7f7f7);
  static const Color BACK_DARK = Color(0xff424242);
  static const Color BLUE_LIGHT = Color(0xff41b7fd);
  static const Color BLUE_DARK = Color(0xff1e7bfd);
  static const Color ORANGE_LIGHT = Color(0xffffce52);
  static const Color ORANGE_DARK = Color(0xffff9a02);
}

class API {
  static const String RESULT = "result";
  static const String DATA = "data";

  static const String REGISTER = "/appuser/register";
  static const String LOGIN = "/appuser/login";
  static const String RESET_PASSWORD = "/appuser/sendResetpasswordEmail";
  static const String UPDATE_PROFILE = "/appuser/upsert";
  static const String CHANGE_PASSWORD = "/appuser/changePassword";
  static const String GET_PROJECT = "/project/get";
  static const String ACCOUNT_INFO = "/account/info";
  static const String ACCOUNT_REFEREES = "/account/referees";
  static const String UPSERT_PLEDGE = "/pledge/upsert";
  static const String GET_FAQ = "/faq/get";
  static const String GET_NEWS = "/news/get";
}

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }
  return double.tryParse(s) != null;
}

showAlertDialog(BuildContext context, String title, String description) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}
