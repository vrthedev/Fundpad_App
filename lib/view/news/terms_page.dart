import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Center(
              child: Text(
                "Terms & Conditions",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Terms",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "A Privacy Policy is a legal statement that specifies what the business owner does with the personal data collected from users, along with how the data is processed.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: COLOR.TEXT_HINT),
            ),
            SizedBox(height: 40),
            Text(
              "Service",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "A Privacy Policy is a legal statement that specifies what the business owner does with the personal data collected from users, along with how the data is processed.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: COLOR.TEXT_HINT),
            ),
          ],
        ),
      ),
    );
  }
}
