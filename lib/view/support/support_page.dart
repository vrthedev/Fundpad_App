import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
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
                      "Contact Info",
                      style: TextStyle(
                        letterSpacing: 1.05,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'support@fundpad.com',
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Contact Fundpad',
                              }),
                            );
                            launchUrl(emailLaunchUri);
                          },
                          title: const Text(
                            "Contact Us",
                            style: TextStyle(
                              color: COLOR.BLUE_LIGHT,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.05,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.email_outlined,
                            color: COLOR.ORANGE_DARK,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text(
                            "Contact Agreement",
                            style: TextStyle(
                              color: COLOR.BLUE_LIGHT,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.05,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: COLOR.ORANGE_DARK,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              color: COLOR.BLUE_LIGHT,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.05,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: COLOR.ORANGE_DARK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
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
                      "Our Website Link",
                      style: TextStyle(
                        letterSpacing: 1.05,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse("https://www.google.com/"));
                          },
                          icon: Image.asset("images/facebook.png"),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse("https://www.google.com/"));
                          },
                          icon: Image.asset("images/twitter.png"),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse("https://www.google.com/"));
                          },
                          icon: Image.asset("images/instagram.png"),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse("https://www.google.com/"));
                          },
                          icon: Image.asset("images/telegram.png"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
