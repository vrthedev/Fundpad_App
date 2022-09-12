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
          selectedItemColor: COLOR.BLUE_PRIMARY,
          unselectedItemColor: COLOR.GRAY_DEACTIVATE,
          currentIndex: _currentIndex,
          items: [
            _getItem("images/ic_home.png", 0),
            _getItem("images/ic_notification.png", 1),
            BottomNavigationBarItem(icon: Container(), label: ""),
            _getItem("images/ic_global.png", 3),
            _getItem("images/ic_person.png", 4),
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
          child: Image.asset("images/ic_chart.png"),
          backgroundColor: COLOR.BLUE_PRIMARY,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  BottomNavigationBarItem _getItem(String image, int index) {
    return BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              color: index == _currentIndex
                  ? COLOR.BLUE_PRIMARY
                  : COLOR.GRAY_DEACTIVATE,
            ),
            index == _currentIndex
                ? const SizedBox(height: 2)
                : const SizedBox.shrink(),
            index == _currentIndex
                ? Image.asset("images/ic_active.png")
                : const SizedBox.shrink()
          ],
        ),
        label: "");
  }
}
