import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences _prefs;

  SharedPreferencesHelper(this._prefs);

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }
}
