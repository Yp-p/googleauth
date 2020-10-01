import 'package:flutter/cupertino.dart';

import 'dark_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static final String IS_DARK_THEME="is_dark_theme";

  Future<void> setDarkTheme(bool isDark) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setBool(IS_DARK_THEME, isDark);

  }

  Future<DarkModel> getDark() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return DarkModel(preferences.getBool(IS_DARK_THEME),);
  }

}





