import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _formKey = GlobalKey<FormState>();
  final teEmail = TextEditingController(text: Globals.currentUser!.email);
  final teUsername = TextEditingController(text: Globals.currentUser!.fullname);
  final tePhone = TextEditingController(text: Globals.currentUser!.phone);
  final teWallet = TextEditingController(text: Globals.currentUser!.wallet);
  final teAddress = TextEditingController(text: Globals.currentUser!.address);

  bool editUsername = false,
      editEmail = false,
      editPhone = false,
      editWallet = false,
      editAddress = false;
  bool isValidEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Account",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: BackWidget(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "User Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            editUsername = !editUsername;
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: COLOR.TEXT_HINT),
                        ))
                  ],
                ),
                TextFormField(
                  controller: teUsername,
                  readOnly: !editUsername,
                  decoration: InputDecoration(
                    hintText: 'Enter User Name',
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
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
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            editEmail = !editEmail;
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: COLOR.TEXT_HINT),
                        ))
                  ],
                ),
                TextFormField(
                  controller: teEmail,
                  readOnly: !editEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
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
                      return 'Please enter email address';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Phone Number",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            editPhone = !editPhone;
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: COLOR.TEXT_HINT),
                        ))
                  ],
                ),
                TextFormField(
                  controller: tePhone,
                  readOnly: !editPhone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter Phone number",
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "USDT TRC20 (RECEIVER)\nWallet Address",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            editWallet = !editWallet;
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: COLOR.TEXT_HINT),
                        ))
                  ],
                ),
                TextFormField(
                  controller: teWallet,
                  decoration: InputDecoration(
                    hintText: 'Enter Wallet address',
                    hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
                    prefixIcon: Image.asset("images/ic_wallet.png"),
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
                      return 'Please enter wallet address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateProfile();
                    }
                  },
                  child: const Text(
                    "Save",
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

  void updateProfile() async {
    FocusScope.of(context).unfocus();

    Map<String, dynamic> data = {};

    if (Globals.currentUser!.fullname != teUsername.text) {
      data["fullname"] = teUsername.text;
    }

    if (Globals.currentUser!.email != teEmail.text) {
      data["email"] = teEmail.text;
    }

    if (Globals.currentUser!.phone != tePhone.text) {
      data["phone"] = tePhone.text;
    }

    if (Globals.currentUser!.wallet != teWallet.text) {
      data["wallet"] = teWallet.text;
    }

    if (Globals.currentUser!.address != teAddress.text) {
      data["address"] = teAddress.text;
    }

    if (data.isEmpty) return;

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.updateProfile(data),
      ),
    );

    if (result == "Success") {
      if (Globals.currentUser!.fullname != teUsername.text) {
        Globals.currentUser!.fullname = teUsername.text;
      }

      if (Globals.currentUser!.email != teEmail.text) {
        Globals.currentUser!.email = teEmail.text;
      }

      if (Globals.currentUser!.phone != tePhone.text) {
        Globals.currentUser!.phone = tePhone.text;
      }

      if (Globals.currentUser!.wallet != teWallet.text) {
        Globals.currentUser!.wallet = teWallet.text;
      }

      if (Globals.currentUser!.address != teAddress.text) {
        Globals.currentUser!.address = teAddress.text;
      }
    } else {
      showToast(result);
    }
  }
}
