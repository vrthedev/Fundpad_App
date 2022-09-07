import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/border_round.dart';
import 'package:fundpad/widget/button_round.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final teEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Password reset',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Enter the Email address associated with',
                  style: TextStyle(
                    color: COLOR.TEXT_HINT,
                  ),
                ),
                const SizedBox(height: 16),
                BorderRound(
                  horizontal: 16,
                  vertical: 2,
                  child: TextFormField(
                    controller: teEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: COLOR.TEXT_HINT),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email address';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ButtonRound(
                  callback: () {
                    if (_formKey.currentState!.validate()) {
                      sendPasswordReset(context);
                    }
                  },
                  child: const Text(
                    "Send Request",
                    style: TextStyle(
                      letterSpacing: 1.05,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPasswordReset(BuildContext ctx) async {
    FocusScope.of(ctx).unfocus();

    String result = await showDialog(
      context: ctx,
      builder: (context) => FutureProgressDialog(
        Util.resetPassword(teEmail.text),
      ),
    );

    if (result == "Success") {
      showToast("Please check your email address");
      Navigator.of(ctx).pop();
    } else {
      showToast(result);
    }
  }
}
