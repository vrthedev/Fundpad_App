import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  double _value = 0;

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
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "CONTACT US",
                            style: TextStyle(
                              color: COLOR.LIGHT_BLUE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 16),
                          Icon(Icons.email_outlined, color: COLOR.LIGHT_BLUE)
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "CONTACT AGREEMENT",
                        style: TextStyle(
                          color: COLOR.LIGHT_BLUE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "TERMS & CONDITIONS",
                        style: TextStyle(
                          color: COLOR.LIGHT_BLUE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "OUR WEBSITE LINK",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: COLOR.LIGHT_BLUE,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.public),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.public),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.public),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.public),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
