import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/globals.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReferralInfo extends StatelessWidget {
  const ReferralInfo({Key? key, required this.code}) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: provider.getThemeMode() == ThemeMode.dark
            ? COLOR.BLACK_BACK
            : Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Referral Info",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF0e1446))),
            child: QrImage(
              data: code,
              version: QrVersions.auto,
              size: 80,
              eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: provider.getThemeMode() == ThemeMode.dark
                      ? Colors.white
                      : Colors.black),
              dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: provider.getThemeMode() == ThemeMode.dark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
          const SizedBox(height: 4),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Image.asset("images/ic_man.png", width: 40),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Globals.currentUser!.fullname,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  code,
                  style: const TextStyle(
                      color: Color(0xff93989F),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: code));
                showToast("Coped to clipboard");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: provider.getThemeMode() == ThemeMode.dark
                      ? COLOR.BACK_DARK
                      : const Color(0xff0E1446),
                ),
                alignment: Alignment.center,
                child: Image.asset("images/ic_copy.png"),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
