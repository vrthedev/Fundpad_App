import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/welcome/login_page.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:fundpad/widget/password_field.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final teNewPassword = TextEditingController();
  final teConfirmPassword = TextEditingController();

  CountryCode code = CountryCode.fromDialCode(Globals.currentUser!.dialcode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: BackWidget(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "New Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                PasswordField(
                  controller: teNewPassword,
                  hint: "Enter New Password",
                  prefixIconColor: COLOR.BLUE_DARK,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter new password';
                    } else if (!Util.isValidatePassword(value)) {
                      return '6-32 Chars: Minumum 1 Upper, 1 Lower & 1 Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                PasswordField(
                  controller: teConfirmPassword,
                  hint: "Enter Confirm Password",
                  prefixIconColor: COLOR.BLUE_DARK,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm password';
                    } else if (value != teNewPassword.text) {
                      return 'Password doesn\'t match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      changePassword();
                    }
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 64),
                    primary: COLOR.BLUE_PRIMARY,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changePassword() async {
    FocusScope.of(context).unfocus();

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.chnagePassword(teNewPassword.text),
      ),
    );

    if (result == "Success") {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      showToast(result);
    }
  }
}
