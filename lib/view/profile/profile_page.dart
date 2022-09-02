import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/welcome/login_page.dart';
import 'package:fundpad/widget/password_field.dart';
import 'package:fundpad/widget/switch_row.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _emailFormKey = GlobalKey<FormState>();
  final teEmail = TextEditingController();
  final _phoneFormKey = GlobalKey<FormState>();
  final tePhone = TextEditingController();
  final _walletFormKey = GlobalKey<FormState>();
  final teWallet = TextEditingController();
  final _passwordFormKey = GlobalKey<FormState>();
  final teOldPassword = TextEditingController();
  final teNewPassword = TextEditingController();
  final teConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: COLOR.LIGHT_BLUE,
                )),
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "PROFILE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: COLOR.LIGHT_BLUE,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Form(
                    key: _emailFormKey,
                    child: TextFormField(
                      controller: teEmail,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: COLOR.LIGHT_BLUE2,
                        ),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (_emailFormKey.currentState!.validate()) {}
                          },
                          icon: const Icon(Icons.save),
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
                  ),
                  Form(
                    key: _phoneFormKey,
                    child: TextFormField(
                      controller: tePhone,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: COLOR.LIGHT_BLUE2,
                        ),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (_phoneFormKey.currentState!.validate()) {}
                          },
                          icon: const Icon(Icons.save),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Form(
                    key: _walletFormKey,
                    child: TextFormField(
                      controller: teWallet,
                      // style: const TextStyle(color: sdTextPrimaryColor),
                      decoration: InputDecoration(
                        hintText: 'Wallet Address',
                        // hintStyle: const TextStyle(color: sdTextSecondaryColor),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.wallet_membership,
                          color: COLOR.LIGHT_BLUE2,
                        ),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (_walletFormKey.currentState!.validate()) {}
                          },
                          icon: const Icon(Icons.save),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter wallet address';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _passwordFormKey,
                child: Column(
                  children: [
                    const Text(
                      "CHANGE PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: COLOR.LIGHT_BLUE2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PasswordField(
                      controller: teOldPassword,
                      // textColor: sdTextPrimaryColor,
                      hint: "Current Password",
                      prefixIconColor: COLOR.LIGHT_BLUE2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current password';
                        } else if (!Util.isValidatePassword(value)) {
                          return '6-32 Chars: Minumum 1 Upper,1 Lower,1 Special Char & 1 Number';
                        }
                        return null;
                      },
                    ),
                    const Divider(height: 4),
                    PasswordField(
                      controller: teNewPassword,
                      // textColor: sdTextPrimaryColor,
                      hint: "New Password",
                      prefixIconColor: COLOR.LIGHT_BLUE2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter new password';
                        } else if (!Util.isValidatePassword(value)) {
                          return '6-32 Chars: Minumum 1 Upper,1 Lower,1 Special Char & 1 Number';
                        }
                        return null;
                      },
                    ),
                    const Divider(height: 4),
                    PasswordField(
                      controller: teConfirmPassword,
                      // textColor: sdTextPrimaryColor,
                      hint: "Confirm Password",
                      prefixIconColor: COLOR.LIGHT_BLUE2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter confirm password';
                        } else if (value != teNewPassword.text) {
                          return 'Password doesn\'t match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_passwordFormKey.currentState!.validate()) {}
                      },
                      child: const Text("Update"),
                      style: ElevatedButton.styleFrom(
                        primary: COLOR.LIGHT_BLUE,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    const Text(
                      "SETTINGS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: COLOR.LIGHT_BLUE,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchRow(
                      title: "Dark Mode",
                      iconData: Icons.brightness_medium_outlined,
                      color: COLOR.PALE_ORANGE, //menuskyBlueColor,
                      isActive: provider.getThemeMode() == ThemeMode.dark,
                      callback: (v) {
                        if (v) {
                          provider.setThemeMode(ThemeMode.dark);
                        } else {
                          provider.setThemeMode(ThemeMode.light);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
