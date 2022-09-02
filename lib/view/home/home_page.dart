import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/view/home/pledge_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            "images/logo.png",
            width: 160,
          ),
          const SizedBox(height: 80),
          const Text(
            "\$ 2,500,000",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: COLOR.PALE_ORANGE,
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: _value,
            onChanged: (v) {
              setState(() {
                _value = v;
              });
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const PledgePage(),
                ),
              );
            },
            child: const Text("PLEDGE"),
            style: ElevatedButton.styleFrom(
              primary: COLOR.LIGHT_BLUE,
              minimumSize: const Size(200, 40),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text("CONTRACT AGREEMENT"),
            style: ElevatedButton.styleFrom(
              primary: COLOR.LIGHT_BLUE,
              minimumSize: const Size(200, 40),
            ),
          ),
        ],
      ),
    );
  }
}
