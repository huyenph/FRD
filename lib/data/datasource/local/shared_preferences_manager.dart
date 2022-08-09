import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/configs/theme/app_theme.dart';

class SharedPreferencesManager {
  static SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future setToken(String token) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setString(prefsTokenKey, token);
  }

  Future<String> get token async {
    SharedPreferences prefs = await _getPrefs();
    return prefs.getString(prefsTokenKey) ?? '';
  }

  Future setTheme(String theme) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setString(prefsThemeKey, theme);
  }

  Future<ThemeData> get theme async {
    SharedPreferences prefs = await _getPrefs();
    String prefsTheme = prefs.getString(prefsThemeKey) ?? lightTheme;
    return prefsTheme == lightTheme ? AppTheme.light : AppTheme.dark;
  }

  Future logout() async {
    await setToken('');
    await setTheme(lightTheme);
  }
}
