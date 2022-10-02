import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Support",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
          ),
          const SizedBox(height: 16),
          BackWidget(
            callback: () {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'contact@legacy1.co.uk',
                query: encodeQueryParameters(<String, String>{
                  'subject': 'Contact Us',
                }),
              );
              launchUrl(emailLaunchUri);
            },
            child: Row(
              children: [
                Image.asset("images/ic_contactus.png"),
                const SizedBox(width: 16),
                const Text(
                  "Contact Us",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BackWidget(
            callback: () => launchUrl(Uri.parse(TELEGRAM_URL)),
            child: Row(
              children: [
                Image.asset(
                  "images/telegram.png",
                  width: 36,
                ),
                const SizedBox(width: 16),
                const Text(
                  "Telegram",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BackWidget(
            callback: () => launchUrl(Uri.parse(SOUT_OVERVIEW)),
            child: Row(
              children: [
                Image.asset("images/ic_agreement.png"),
                const SizedBox(width: 16),
                const Text(
                  "SouthOne Overview",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BackWidget(
            callback: () => launchUrl(Uri.parse(SOUT_AGREE)),
            child: Row(
              children: [
                Image.asset("images/ic_agreement.png"),
                const SizedBox(width: 16),
                const Text(
                  "SouthOne Agreement",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BackWidget(
            callback: () => launchUrl(Uri.parse(USER_AGREE)),
            child: Row(
              children: [
                Image.asset("images/ic_agreement.png"),
                const SizedBox(width: 16),
                const Text(
                  "User Agreement",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BackWidget(
            callback: () => launchUrl(Uri.parse(TERMS_CONDITION)),
            child: Row(
              children: [
                Image.asset("images/ic_terms.png"),
                const SizedBox(width: 16),
                const Text(
                  "Terms & Conditions",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
