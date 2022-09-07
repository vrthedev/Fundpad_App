import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/welcome/login_page.dart';
import 'package:fundpad/view/welcome/scan_code.dart';
import 'package:fundpad/widget/border_round.dart';
import 'package:fundpad/widget/button_round.dart';
import 'package:fundpad/widget/password_field.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final teEmail = TextEditingController();
  final tePassword = TextEditingController();
  final teCPassword = TextEditingController();
  final teReferralCode = TextEditingController();
  final teUsername = TextEditingController();
  final tePhone = TextEditingController();
  final teWallet = TextEditingController();
  final teHomeAddress = TextEditingController();
  CountryCode code = CountryCode.fromCountryCode("US");

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
                    "Create an account",
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
                  const SizedBox(height: 8),
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: TextFormField(
                      controller: teUsername,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: COLOR.TEXT_HINT),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: PasswordField(
                      controller: tePassword,
                      hint: "Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (!Util.isValidatePassword(value)) {
                          return '6-32 Chars: Minumum 1 Upper,1 Lower,1 Special Char & 1 Number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: PasswordField(
                      controller: teCPassword,
                      hint: "Confirm Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter confirm password';
                        } else if (value != tePassword.text) {
                          return 'Password doesn\'t match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: TextFormField(
                      controller: teReferralCode,
                      decoration: InputDecoration(
                        hintText: 'Referral code',
                        hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => ScanCode(
                                  callback: (code) {
                                    teReferralCode.text = code;
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.qr_code,
                            color: COLOR.ORANGE_DARK,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter referral code';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: Row(
                      children: [
                        CountryCodePicker(
                          onChanged: (code) {
                            this.code = code;
                          },
                          initialSelection: "US",
                          favorite: const ["US", "ES"],
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: false,
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: COLOR.TEXT_HINT,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: tePhone,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone number"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: TextFormField(
                      controller: teWallet,
                      decoration: const InputDecoration(
                        hintText: 'Wallet address',
                        hintStyle: TextStyle(color: COLOR.TEXT_HINT),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  BorderRound(
                    horizontal: 16,
                    vertical: 2,
                    child: TextFormField(
                      controller: teHomeAddress,
                      decoration: const InputDecoration(
                        hintText: 'Home Address',
                        hintStyle: TextStyle(color: COLOR.TEXT_HINT),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ButtonRound(
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        signup();
                      }
                    },
                    child: const Text(
                      "Register Now",
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
                        'Already have an account?',
                        style: TextStyle(color: COLOR.TEXT_HINT),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          CupertinoPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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

  void signup() async {
    FocusScope.of(context).unfocus();

    String phone = tePhone.text.trim();

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.signup(
          teUsername.text,
          teEmail.text,
          tePassword.text,
          teReferralCode.text,
          dialCode: phone.isEmpty ? null : code.dialCode,
          phone: phone.isEmpty ? null : phone,
          wallet: teWallet.text,
          address: teHomeAddress.text,
        ),
      ),
    );

    if (result == "Success") {
      showToast("Your account is created. Please login");
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
