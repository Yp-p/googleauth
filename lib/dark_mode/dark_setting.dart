
import 'package:flutter/material.dart';
import '';

import 'dark_prefs.dart';

class DarkSetting extends ChangeNotifier{
  bool _isDark=false;

  DarkSetting(){
    _loadTheme();
  }
  void _loadTheme(){
    debugPrint('Entered LoadTheme');
    Prefs().getDark().then((setting) {
      _isDark = setting.isDark ?? false;
      notifyListeners();
    }
    );
  }

  bool isDarkTheme(){
    return _isDark;
  }
  ThemeMode currentTheme(){
    return _isDark?ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme(){
    _isDark=!_isDark;
    Prefs().setDarkTheme(_isDark).then((value) => notifyListeners());
  }

}