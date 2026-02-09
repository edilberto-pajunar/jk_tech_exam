import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _prefs;

  SharedPreferenceService({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
