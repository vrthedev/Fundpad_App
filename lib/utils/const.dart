// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String BASE_URL = "http://www.google.com";
// const String BASE_URL = "http://10.10.11.153:8000";

class COLOR {
  static const Color TEXT_HINT = Color(0xff7c7c7c);
  static const Color AUTH_BACK = Color(0xffF3F4F8);
  static const Color LIGHT_BLUE = Color(0xffADD8E6);
  static const Color LIGHT_BLUE2 = Color(0xffADe6e6);
  static const Color SAGE_GREEN = Color(0xffB2AC88);
  static const Color PALE_ORANGE = Color(0xffFFCD9B);
}

class KEY {
  static const String SAVED_USER = "fundpad_saved_user";
}

class API {
  static const String REGISTER = "/api/register";
  static const String LOGIN = "/api/login";
  static const String RESET_PASSWORD = "/api/reset_password";
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
