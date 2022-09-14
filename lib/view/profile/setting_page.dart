import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/view/welcome/login_page.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isSupported = false;
  bool _isAuthorized = false;

  @override
  void initState() {
    super.initState();

    auth.isDeviceSupported().then(
          (v) => setState(() => _isSupported = v),
        );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      setState(() {
        _isAuthorized = authenticated;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Setting",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: BackWidget(
        radius: 0,
        child: Column(
          children: [
            ListTile(
              title: const Text(
                "Face ID",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              trailing: CupertinoSwitch(
                value: _isAuthorized,
                onChanged: (v) {
                  if (v) {
                    if (_isSupported) {
                      _authenticate();
                    } else {
                      showToast("This device is not supported");
                    }
                  }
                },
                activeColor: COLOR.ORANGE_PRIMARY,
              ),
            ),
            ListTile(
              title: const Text(
                "Dark Mode",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              trailing: CupertinoSwitch(
                value: provider.getThemeMode() == ThemeMode.dark,
                onChanged: (v) {
                  if (v) {
                    provider.setThemeMode(ThemeMode.dark);
                  } else {
                    provider.setThemeMode(ThemeMode.light);
                  }
                },
                activeColor: COLOR.ORANGE_PRIMARY,
              ),
            ),
            ListTile(
              title: const Text(
                "Notifications",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              trailing: CupertinoSwitch(
                value: Globals.currentUser!.notificationActive,
                onChanged: (v) {
                  setState(() {
                    Globals.currentUser!.notificationActive = v;
                  });
                  updateProfile(v);
                },
                activeColor: COLOR.ORANGE_PRIMARY,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              title: const Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: Image.asset("images/ic_logout.png"),
            ),
            const Spacer(),
            ListTile(
              onTap: showDeleteConfirm,
              title: const Text(
                "Delete Account",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: COLOR.PURPLE.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile(bool flag) async {
    Map<String, dynamic> data = {
      'notification_active': flag,
    };

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Util.updateProfile(data),
      ),
    );

    if (result == "Success") {
    } else {
      showToast(result);
    }
  }

  void showDeleteConfirm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Are you sure to delete your account?"),
            actions: [
              TextButton(onPressed: deleteAccount, child: const Text("OK")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
            ],
          );
        });
  }

  void deleteAccount() async {
    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(Util.deleteAccount()),
    );

    if (result == "Success") {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const LoginPage()));
    } else {
      showToast(result);
    }
  }
}
