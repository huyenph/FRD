import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String tokenKey = 'token';

  static SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future setToken(String token) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setString(tokenKey, token);
  }

  Future<String> get token async {
    SharedPreferences prefs = await _getPrefs();
    return prefs.getString(tokenKey) ?? '';
  }

  Future logout() async {
    await setToken('');
  }
}
