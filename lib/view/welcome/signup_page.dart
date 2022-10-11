import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/welcome/login_page.dart';
import 'package:fundpad/view/welcome/scan_code.dart';
import 'package:fundpad/view/welcome/success_page.dart';
import 'package:fundpad/widget/password_field.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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

  bool isValidEmail = false;
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "User Name",
                            style: TextStyle(
                                color: COLOR.TEXT_HINT,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: teUsername,
                            decoration: InputDecoration(
                              hintText: 'Enter User Name',
                              hintStyle:
                                  const TextStyle(color: COLOR.TEXT_HINT),
                              prefixIcon: Image.asset("images/ic_username.png"),
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
                                return 'Please enter user name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
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
                                  ? Image.asset("images/ic_check_green.png")
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
                              } else if (!Util.isValidatePassword(value)) {
                                return '6+ Chars: 1 Upper, 1 Lower & 1 Number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Confirm Password",
                            style: TextStyle(
                                color: COLOR.TEXT_HINT,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          PasswordField(
                            controller: teCPassword,
                            hint: "Enter Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter confirm password';
                              } else if (value != tePassword.text) {
                                return 'Password doesn\'t match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Referral code",
                            style: TextStyle(
                                color: COLOR.TEXT_HINT,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: teReferralCode,
                            decoration: InputDecoration(
                              hintText: 'Enter or Scan Referral code',
                              hintStyle:
                                  const TextStyle(color: COLOR.TEXT_HINT),
                              prefixIcon: Image.asset("images/ic_refer.png"),
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
                                  color: COLOR.BLUE_SECONDARY,
                                ),
                              ),
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
                                return 'Please enter referral code';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Phone Number",
                            style: TextStyle(
                                color: COLOR.TEXT_HINT,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: tePhone,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Enter Phone number",
                              hintStyle:
                                  const TextStyle(color: COLOR.TEXT_HINT),
                              prefixIcon: Image.asset("images/ic_phone.png"),
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
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                  value: isAccepted,
                                  onChanged: (v) {
                                    setState(() {
                                      isAccepted = v ?? false;
                                    });
                                  }),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: COLOR.TEXT_HINT),
                                      children: [
                                        const TextSpan(text: "I agree to "),
                                        TextSpan(
                                          text:
                                              'Privacy Policy and Terms & Conditions',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: COLOR.BLUE_SECONDARY),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Uri uri = Uri.parse(
                                                  "http://www.legacy1.co.uk/privacy-policy/");
                                              launchUrl(uri);
                                            },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signup();
                              }
                            },
                            child: const Text(
                              "Sign Up",
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
                        'Sign in',
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

  void signup() async {
    if (!isAccepted) return;

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
          phone: phone.isEmpty ? null : phone,
        ),
      ),
    );

    if (result == "Success") {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const SuccessPage(),
        ),
      );
    } else {
      showToast(result);
    }
  }
}
