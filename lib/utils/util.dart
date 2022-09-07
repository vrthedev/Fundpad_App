import 'dart:convert';

import 'package:fundpad/model/account_info.dart';
import 'package:fundpad/model/app_user.dart';
import 'package:fundpad/model/faq.dart';
import 'package:fundpad/model/project.dart';
import 'package:fundpad/model/referee.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:http/http.dart' as http;

class Util {
  static bool isValidatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static String formattedCommaString(String value) {
    return value.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  static String stringWithoutTrailingZero(double value) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return value.toString().replaceAll(regex, '');
  }

  static Future<String> signup(
      String fullname, String email, String password, String referralCode,
      {String? dialCode,
      String? phone,
      String? wallet,
      String? address}) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(BASE_URL + API.REGISTER),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'fullname': fullname,
            'email': email,
            'password': password,
            'register_referral_code': referralCode,
            'device_token': Globals.deviceToken,
            'dialcode': dialCode,
            'phone': phone,
            'wallet': wallet,
            'address': address,
          },
        ),
      );

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return "Success";
      } else {
        return result[API.DATA] ?? "";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> login(String email, String password) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.LOGIN),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                'email': email,
                'password': password,
                'device_token': Globals.deviceToken,
              }));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        Globals.currentUser = AppUser.fromJson(result[API.DATA]);
        return "Success";
      } else {
        return result[API.DATA] ?? "";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> resetPassword(String email) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.RESET_PASSWORD),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                'email': email,
              }));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return "Success";
      } else {
        return result[API.DATA] ?? "";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> updateProfile(Map<String, dynamic> data) async {
    try {
      data["_id"] = Globals.currentUser!.id;
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.UPDATE_PROFILE),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(data));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return "Success";
      } else {
        return result[API.DATA] ?? "";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> chnagePassword(String newPassword) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(BASE_URL + API.CHANGE_PASSWORD),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': Globals.currentUser!.email,
            'new_password': newPassword,
          },
        ),
      );
      print(response.body);
      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return "Success";
      } else {
        return result[API.DATA] ?? "";
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  static Future<Project> getProject() async {
    try {
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.GET_PROJECT),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{}));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return Project.fromJson(result[API.DATA]);
      } else {
        throw result[API.DATA];
      }
    } catch (e) {
      throw 'Connection Error';
    }
  }

  static Future<AccountInfo> getAccountInfo() async {
    try {
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.ACCOUNT_INFO),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                "app_user_id": Globals.currentUser!.id,
              }));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return AccountInfo.fromJson(result[API.DATA]);
      } else {
        throw result[API.DATA];
      }
    } catch (e) {
      throw 'Connection Error';
    }
  }

  static Future<String> createPledge(
      String transaction, String amount, String wallet) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(BASE_URL + API.UPSERT_PLEDGE),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'investor_id': Globals.currentUser!.id,
            'transaction': transaction,
            'amount': amount,
            'wallet': wallet,
          },
        ),
      );

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return "Success";
      } else {
        return result[API.DATA] ?? "";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Referee>> accountReferees() async {
    try {
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.ACCOUNT_REFEREES),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                "app_user_id": Globals.currentUser!.id,
              }));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return Referee.fromJsonList(result[API.DATA]);
      } else {
        throw result[API.DATA];
      }
    } catch (e) {
      throw 'Connection Error';
    }
  }

  static Future<List<Faq>> getNews() async {
    try {
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.GET_NEWS),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{}));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return Faq.fromJsonList(result[API.DATA]);
      } else {
        throw result[API.DATA];
      }
    } catch (e) {
      throw 'Connection Error';
    }
  }

  static Future<List<Faq>> getFaq() async {
    try {
      final http.Response response =
          await http.post(Uri.parse(BASE_URL + API.GET_FAQ),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{}));

      Map<String, dynamic> result = json.decode(response.body);

      if (result[API.RESULT] == true) {
        return Faq.fromJsonList(result[API.DATA]);
      } else {
        throw result[API.DATA];
      }
    } catch (e) {
      throw 'Connection Error';
    }
  }
}
