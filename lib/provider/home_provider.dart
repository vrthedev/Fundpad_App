import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    SharedPreferences.getInstance().then((pref) {
      var themeMode = pref.get("THEME_MODE") ?? "light";
      if (themeMode == "light") {
        _mode = ThemeMode.light;
      } else {
        _mode = ThemeMode.dark;
      }
      notifyListeners();
    });
  }

  ThemeMode? _mode;

  ThemeMode getThemeMode() {
    return _mode ?? ThemeMode.light;
  }

  void setThemeMode(ThemeMode mode) async {
    _mode = mode;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.light) {
      await pref.setString("THEME_MODE", "light");
    } else {
      await pref.setString("THEME_MODE", "dark");
    }

    notifyListeners();
  }
}
