import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/main_page.dart';
import 'package:fundpad/view/welcome/forgot_password_page.dart';
import 'package:fundpad/view/welcome/signup_page.dart';
import 'package:fundpad/widget/border_round.dart';
import 'package:fundpad/widget/button_round.dart';
import 'package:fundpad/widget/password_field.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final teEmail = TextEditingController();
  final tePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 32),
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
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: PasswordField(
                      controller: tePassword,
                      hint: "Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        // else if (!Util.isValidatePassword(value)) {
                        //   return '6-32 Chars: Minumum 1 Upper,1 Lower,1 Special Char & 1 Number';
                        // }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot password?",
                      ),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: COLOR.BLUE_DARK,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ButtonRound(
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        letterSpacing: 1.05,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: COLOR.TEXT_HINT),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          CupertinoPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: COLOR.BLUE_DARK,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    ));
  }

  void login() async {
    FocusScope.of(context).unfocus();

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.login(teEmail.text, tePassword.text),
      ),
    );

    if (result == "Success") {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    } else {
      showToast(result);
    }
  }
}
