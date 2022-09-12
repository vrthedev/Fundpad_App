import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
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
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
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
                TextFormField(
                  controller: teEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
                    prefixIcon: const Icon(Icons.email),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: COLOR.BLUE_SECONDARY,
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: COLOR.GRAY_BORDER,
                        width: 1.5,
                      ),
                    ),
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendPasswordReset(context);
                    }
                  },
                  child: const Text(
                    "Send Request",
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
