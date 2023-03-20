import 'package:shared_preferences/shared_preferences.dart';
import 'package:hpcompose/common/constants.dart';

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

  Future logout() async {
    await setToken('');
  }
}
