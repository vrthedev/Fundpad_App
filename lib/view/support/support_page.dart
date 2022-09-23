import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/view/news/terms_page.dart';
import 'package:fundpad/widget/back_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
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
                        "Southone Agreement",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                BackWidget(
                  callback: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => const TermsPage()));
                  },
                  child: Row(
                    children: [
                      Image.asset("images/ic_terms.png"),
                      const SizedBox(width: 16),
                      const Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
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
              children: [
                const Text(
                  "Social Media",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse("https://www.google.com/"));
                  },
                  icon: Image.asset("images/telegram.png"),
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
