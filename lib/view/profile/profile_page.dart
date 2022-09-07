import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/welcome/login_page.dart';
import 'package:fundpad/widget/button_round.dart';
import 'package:fundpad/widget/password_field.dart';
import 'package:fundpad/widget/referral_info.dart';
import 'package:fundpad/widget/switch_row.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _emailFormKey = GlobalKey<FormState>();
  final teEmail = TextEditingController(text: Globals.currentUser!.email);
  final _usernameFormKey = GlobalKey<FormState>();
  final teUsername = TextEditingController(text: Globals.currentUser!.fullname);
  final _phoneFormKey = GlobalKey<FormState>();
  final tePhone = TextEditingController(text: Globals.currentUser!.phone);
  final _walletFormKey = GlobalKey<FormState>();
  final teWallet = TextEditingController(text: Globals.currentUser!.wallet);
  final _homeAddressFormKey = GlobalKey<FormState>();
  final teAddress = TextEditingController(text: Globals.currentUser!.address);
  final _passwordFormKey = GlobalKey<FormState>();
  final teNewPassword = TextEditingController();
  final teConfirmPassword = TextEditingController();

  CountryCode code = CountryCode.fromDialCode(Globals.currentUser!.dialcode);

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
                  color: COLOR.BLUE_LIGHT,
                )),
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [COLOR.BLUE_LIGHT, COLOR.BLUE_DARK]),
                  ),
                  child: const Text(
                    "Profile",
                    style: TextStyle(
                      letterSpacing: 1.05,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _emailFormKey,
                        child: TextFormField(
                          controller: teEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.email_outlined),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (_emailFormKey.currentState!.validate()) {
                                  updateProfile(
                                      "email", {"email": teEmail.text});
                                }
                              },
                              icon: const Icon(
                                Icons.save,
                                color: COLOR.BLUE_LIGHT,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email address';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Invalid email address';
                            } else if (Globals.currentUser!.email == value) {
                              return 'Email address is already registered';
                            }
                            return null;
                          },
                        ),
                      ),
                      Form(
                        key: _usernameFormKey,
                        child: TextFormField(
                          controller: teUsername,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.person),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (_usernameFormKey.currentState!.validate()) {
                                  updateProfile("fullname",
                                      {"fullname": teUsername.text});
                                }
                              },
                              icon: const Icon(
                                Icons.save,
                                color: COLOR.BLUE_LIGHT,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            } else if (Globals.currentUser!.fullname == value) {
                              return 'Username is already registered';
                            }
                            return null;
                          },
                        ),
                      ),
                      Form(
                        key: _phoneFormKey,
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
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: tePhone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: 'Phone number',
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (_phoneFormKey.currentState!
                                          .validate()) {
                                        updateProfile("phone", {
                                          "dialcode": code.dialCode,
                                          "phone": tePhone.text
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.save,
                                      color: COLOR.BLUE_LIGHT,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter phone number';
                                  } else if (Globals.currentUser!.dialcode ==
                                          code.dialCode &&
                                      Globals.currentUser!.phone == value) {
                                    return 'Phone number is already registered';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Form(
                        key: _walletFormKey,
                        child: TextFormField(
                          controller: teWallet,
                          decoration: InputDecoration(
                            hintText: 'Wallet Address',
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.wallet_membership),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (_walletFormKey.currentState!.validate()) {
                                  updateProfile(
                                      "wallet", {"wallet": teWallet.text});
                                }
                              },
                              icon: const Icon(
                                Icons.save,
                                color: COLOR.BLUE_LIGHT,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter wallet address';
                            } else if (Globals.currentUser!.wallet == value) {
                              return 'Wallet address is already registered';
                            }
                            return null;
                          },
                        ),
                      ),
                      Form(
                        key: _homeAddressFormKey,
                        child: TextFormField(
                          controller: teAddress,
                          decoration: InputDecoration(
                            hintText: 'Home Address',
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.location_on),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (_homeAddressFormKey.currentState!
                                    .validate()) {
                                  updateProfile(
                                      "address", {"address": teAddress.text});
                                }
                              },
                              icon: const Icon(
                                Icons.save,
                                color: COLOR.BLUE_LIGHT,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter home address';
                            } else if (Globals.currentUser!.address == value) {
                              return 'Home address is already registered';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [COLOR.BLUE_LIGHT, COLOR.BLUE_DARK]),
                  ),
                  child: const Text(
                    "Change Password",
                    style: TextStyle(
                      letterSpacing: 1.05,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Form(
                    key: _passwordFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PasswordField(
                          controller: teNewPassword,
                          hint: "New Password",
                          prefixIconColor: COLOR.BLUE_DARK,
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
                          hint: "Confirm Password",
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
                        const SizedBox(height: 8),
                        ButtonRound(
                          callback: () {
                            if (_passwordFormKey.currentState!.validate()) {
                              changePassword();
                            }
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              letterSpacing: 1.05,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [COLOR.BLUE_LIGHT, COLOR.BLUE_DARK]),
                  ),
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      letterSpacing: 1.05,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: SwitchRow(
                      title: "Dark Mode",
                      iconData: Icons.brightness_medium_outlined,
                      color: COLOR.ORANGE_LIGHT, //menuskyBlueColor,
                      isActive: provider.getThemeMode() == ThemeMode.dark,
                      callback: (v) {
                        if (v) {
                          provider.setThemeMode(ThemeMode.dark);
                        } else {
                          provider.setThemeMode(ThemeMode.light);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ReferralInfo(code: Globals.currentUser!.referralCode),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void updateProfile(String key, Map<String, dynamic> data) async {
    FocusScope.of(context).unfocus();

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.updateProfile(data),
      ),
    );

    if (result == "Success") {
      switch (key) {
        case "email":
          Globals.currentUser!.email = teEmail.text;
          break;
        case "fullname":
          Globals.currentUser!.fullname = teUsername.text;
          break;
        case "phone":
          Globals.currentUser!.dialcode = code.dialCode!;
          Globals.currentUser!.phone = tePhone.text;
          break;
        default:
      }
    } else {
      showToast(result);
    }
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
