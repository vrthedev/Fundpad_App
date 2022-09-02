import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/main_page.dart';
import 'package:fundpad/view/welcome/login_page.dart';
import 'package:fundpad/widget/password_field.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "SIGN UP",
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
                          )),
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
                    TextFormField(
                      controller: teUsername,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      decoration: const InputDecoration(
                          hintText: 'Username',
                          // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: COLOR.LIGHT_BLUE2,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
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
                    PasswordField(
                      controller: teCPassword,
                      // textColor: sdTextPrimaryColor,
                      hint: "Confirm Password",
                      prefixIconColor: COLOR.LIGHT_BLUE2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter confirm password';
                        } else if (value != tePassword.text) {
                          return 'Password doesn\'t match';
                        }
                        return null;
                      },
                    ),
                    const Divider(height: 4),
                    TextFormField(
                      controller: teReferralCode,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      // keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          hintText: 'Referral code',
                          // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.code,
                            color: COLOR.LIGHT_BLUE2,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter referral code';
                        }
                        return null;
                      },
                    ),
                    const Divider(height: 4),
                    Row(
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
                    const Divider(height: 4),
                    TextFormField(
                      controller: teWallet,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      decoration: const InputDecoration(
                          hintText: 'Wallet address',
                          // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.wallet_membership,
                            color: COLOR.LIGHT_BLUE2,
                          )),
                    ),
                    const Divider(height: 4),
                    TextFormField(
                      controller: teEmail,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      decoration: const InputDecoration(
                          hintText: 'Home Address',
                          // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: COLOR.LIGHT_BLUE2,
                          )),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signup();
                        }
                      },
                      child: const Text(
                        "SIGN UP",
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: COLOR.TEXT_HINT),
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          ),
                          child: const Text(
                            'SIGN IN',
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
      //           'Already have an account?',
      //           style: TextStyle(color: COLOR.TEXT_HINT),
      //         ),
      //         TextButton(
      //           onPressed: () => Navigator.of(context).pushReplacement(
      //             CupertinoPageRoute(
      //               builder: (context) => const LoginPage(),
      //             ),
      //           ),
      //           child: const Text(
      //             'SIGN IN',
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

  void signup() async {
    FocusScope.of(context).unfocus();

    String phone = tePhone.text.trim();
    if (phone.isNotEmpty) {
      String fullPhone = code.dialCode! + tePhone.text.trim();
    }

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }
}
