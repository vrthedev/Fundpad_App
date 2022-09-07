import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/view/account/account_page.dart';
import 'package:fundpad/view/home/home_page.dart';
import 'package:fundpad/view/news/news_page.dart';
import 'package:fundpad/view/profile/profile_page.dart';
import 'package:fundpad/view/support/support_page.dart';
import 'package:fundpad/view/welcome/login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int _currentIndex = 0;
  late List<Widget> tabs;
  DateTime? _backgroundTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    tabs = const [
      HomePage(),
      NewsPage(),
      AccountPage(),
      SupportPage(),
      ProfilePage()
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Activate

        if (_backgroundTime != null) {
          DateTime expired = _backgroundTime!.add(const Duration(seconds: 30));

          if (expired.isBefore(DateTime.now())) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          } else {
            _backgroundTime = null;
          }
        }

        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // Deactivate
        _backgroundTime = DateTime.now();

        break;
      default:
    }
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
          selectedItemColor: COLOR.BLUE_DARK,
          unselectedItemColor: COLOR.TEXT_HINT,
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
          backgroundColor: COLOR.BLUE_DARK,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  BottomNavigationBarItem _getItem(IconData iconData, String label) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: "");
  }
}
