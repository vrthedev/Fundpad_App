import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/view/account/account_page.dart';
import 'package:fundpad/view/home/home_page.dart';
import 'package:fundpad/view/news/news_page.dart';
import 'package:fundpad/view/profile/profile_page.dart';
import 'package:fundpad/view/support/support_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    tabs = const [
      HomePage(),
      NewsPage(),
      AccountPage(),
      SupportPage(),
      ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: COLOR.LIGHT_BLUE,
          // unselectedItemColor: sdIconColor,
          currentIndex: _currentIndex,
          items: [
            _getItem(Icons.home, "Home"),
            _getItem(Icons.newspaper, "News"),
            BottomNavigationBarItem(icon: Container(), label: ""),
            _getItem(Icons.email, "Supports"),
            _getItem(Icons.person, "Profile"),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 2;
            });
          },
          child: const Icon(Icons.bar_chart),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  BottomNavigationBarItem _getItem(IconData iconData, String label) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: "");
  }
}
