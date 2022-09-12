import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:fundpad/view/profile/change_password.dart';
import 'package:fundpad/view/profile/my_account.dart';
import 'package:fundpad/view/profile/setting_page.dart';
import 'package:fundpad/widget/referral_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset("images/ic_profile.png", width: 112),
              InkWell(
                onTap: () {},
                child: Image.asset("images/ic_edit.png"),
              ),
            ],
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => const MyAccount()),
              );
            },
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: COLOR.PURPLE.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.person,
                color: COLOR.BLUE_PRIMARY,
              ),
            ),
            title: const Text(
              "My Account",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffB7BAC2),
              size: 14,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                    builder: (context) => const ChangePassword()),
              );
            },
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: COLOR.PURPLE.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.key,
                color: COLOR.BLUE_PRIMARY,
              ),
            ),
            title: const Text(
              "Change Password",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffB7BAC2),
              size: 14,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => const SettingPage()),
              );
            },
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: COLOR.PURPLE.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.settings,
                color: COLOR.BLUE_PRIMARY,
              ),
            ),
            title: const Text(
              "Setting",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffB7BAC2),
              size: 14,
            ),
          ),
          ReferralInfo(code: Globals.currentUser!.referralCode),
        ],
      ),
    );
  }
}
