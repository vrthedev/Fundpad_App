import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/main_page.dart';
import 'package:fundpad/view/welcome/forgot_password_page.dart';
import 'package:fundpad/view/welcome/signup_page.dart';
import 'package:fundpad/widget/password_field.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: COLOR.LIGHT_BLUE,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: teEmail,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: COLOR.LIGHT_BLUE2,
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
                    const Divider(height: 4),
                    PasswordField(
                      controller: tePassword,
                      // textColor: sdTextPrimaryColor,
                      hint: "Password",
                      prefixIconColor: COLOR.LIGHT_BLUE2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (!Util.isValidatePassword(value)) {
                          return '6-32 Chars: Minumum 1 Upper,1 Lower,1 Special Char & 1 Number';
                        }
                        return null;
                      },
                    ),
                    const Divider(height: 4),
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
                          style: TextStyle(color: COLOR.LIGHT_BLUE),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: COLOR.LIGHT_BLUE,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: COLOR.TEXT_HINT),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          ),
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
      // persistentFooterButtons: [
      //   Container(
      //     height: 40,
      //     padding: const EdgeInsets.symmetric(horizontal: 15),
      //     width: MediaQuery.of(context).copyWith().size.width,
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         const Text(
      //           'Don\'t have an account?',
      //           style: TextStyle(color: COLOR.TEXT_HINT),
      //         ),
      //         TextButton(
      //           onPressed: () => Navigator.of(context).pushReplacement(
      //             CupertinoPageRoute(
      //               builder: (context) => const SignupPage(),
      //             ),
      //           ),
      //           child: const Text(
      //             'REGISTER',
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               color: COLOR.LIGHT_BLUE,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   )
      // ],
    ));
  }

  void login() async {
    FocusScope.of(context).unfocus();

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }
}
