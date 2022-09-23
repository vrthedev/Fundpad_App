import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/main_page.dart';
import 'package:fundpad/view/welcome/forgot_password_page.dart';
import 'package:fundpad/view/welcome/signup_page.dart';
import 'package:fundpad/widget/password_field.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final teEmail = TextEditingController();
  final tePassword = TextEditingController();

  bool isValidEmail = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Image.asset(provider.getThemeMode() == ThemeMode.dark
                //     ? "images/logo_welcome_white.png"
                //     : "images/logo_welcome_black.png"),
                Image.asset(
                  'images/logol1.png',
                  height: 40,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Welcome back",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                color: COLOR.TEXT_HINT,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: teEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                              hintStyle:
                                  const TextStyle(color: COLOR.TEXT_HINT),
                              prefixIcon: Image.asset("images/ic_email.png"),
                              suffixIcon: isValidEmail
                                  ? Image.asset("images/ic_check.png")
                                  : null,
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
                                setState(() {
                                  isValidEmail = false;
                                });
                                return 'Please enter email address';
                              } else if (!EmailValidator.validate(value)) {
                                setState(() {
                                  isValidEmail = false;
                                });
                                return 'Invalid email address';
                              }

                              setState(() {
                                isValidEmail = true;
                              });
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Password",
                            style: TextStyle(
                                color: COLOR.TEXT_HINT,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          PasswordField(
                            controller: tePassword,
                            hint: "Enter Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              // else if (!Util.isValidatePassword(value)) {
                              //   return '6-32 Chars: Minumum 1 Upper, 1 Lower & 1 Number';
                              // }
                              return null;
                            },
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
                              child: const Text("Forgot password?"),
                              style: TextButton.styleFrom(
                                primary: COLOR.TEXT_HINT,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: const Text(
                              "Log In",
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
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: COLOR.BLUE_PRIMARY,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
