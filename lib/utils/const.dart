// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String BASE_URL = "https://xeaufaashbvr.legacy1.co.uk/api";
const String TELEGRAM_URL = "https://t.me/+6U2jXYg7nAVjZTI0";
const String SOUT_OVERVIEW = "https://legacy1.co.uk/southone_overview.pdf";
const String SOUT_AGREE = "https://legacy1.co.uk/southone_agreement.pdf";
const String USER_AGREE = "https://legacy1.co.uk/user_agreement.pdf";
const String TERMS_CONDITION = "https://legacy1.co.uk/terms_conditions.pdf";

class COLOR {
  static const Color SPLASH_BACKGROUND = Color(0xff0E1446);
  static const Color BLUE_PRIMARY = Color(0xff6D43FD);
  static const Color BLUE_SECONDARY = Color(0xFF4162FF);
  static const Color TEXT_HINT = Color(0xff848AA4);
  static const Color TEXT_RED = Color(0xffFC2222);
  static const Color GRAY_BORDER = Color(0xffE0E0E0);
  static const Color ORANGE_PRIMARY = Color(0xffFC8440);
  static const Color GRAY_DEACTIVATE = Color(0xffDADFE7);
  static const Color PURPLE = Color(0xff9896FF);
  static const Color BLACK_BACK = Color(0xFF0D0D0D);
  static const Color BACK_DARK = Color(0xff1A1919);
  static const Color SCAFFOLD_LIGHT = Color(0xffEBF0FF);
  static const Color SCAFFOLD_DARK = Color(0xff171717);

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
  static const String DELETE_ACCOUNT = "/appuser/delete";
  static const String GET_PROJECT = "/project/get";
  static const String ACCOUNT_INFO = "/account/info";
  static const String ACCOUNT_REFEREES = "/account/referees";
  static const String ACCOUNT_REFERRALS = "/account/referrals";
  static const String GET_PLEDGE = "/pledge/get";
  static const String UPSERT_PLEDGE = "/pledge/upsert";
  static const String GET_FAQ = "/faq/get";
  static const String GET_NEWS = "/news/get";
  static const String MAIL_DEPOSIT = "/mail/depositAddress";
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
