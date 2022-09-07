import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundpad/utils/const.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReferralInfo extends StatelessWidget {
  const ReferralInfo({Key? key, required this.code}) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [COLOR.BLUE_LIGHT, COLOR.BLUE_DARK]),
            ),
            child: const Text(
              "Referral Info",
              style: TextStyle(
                letterSpacing: 1.05,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImage(
                data: code,
                version: QrVersions.auto,
                size: 160,
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  code,
                  style: const TextStyle(
                      letterSpacing: 1.05,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  icon: const Icon(Icons.copy),
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }
}
