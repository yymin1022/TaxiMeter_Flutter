import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  PreferenceUtil._privateConstructor();
  static final PreferenceUtil _instance = PreferenceUtil._privateConstructor();

  factory PreferenceUtil() {
    return _instance;
  }

  SharedPreferences? prefs;

  Future<void> _initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool?> getPrefesValueB(String key) async {
    if(prefs == null) {
      await _initPrefs();
    }

    if(prefs != null) {
      return prefs!.getBool(key);
    }
    return null;
  }

  Future<int?> getPrefsValueI(String key) async {
    if(prefs == null) {
      await _initPrefs();
    }

    if(prefs != null) {
      return prefs!.getInt(key);
    }
    return null;
  }

  Future<String?> getPrefsValueS(String key) async {
    if(prefs == null) {
      await _initPrefs();
    }

    if(prefs != null) {
      return prefs!.getString(key);
    }
    return null;
  }

  Future<void> setPrefsValue(String key, dynamic value) async {
    if(prefs == null) {
      await _initPrefs();
    }

    if(prefs != null) {
      if(value is String) {
        prefs!.setString(key, value);
      } else if(value is int) {
        prefs!.setInt(key, value);
      } else if(value is bool) {
        prefs!.setBool(key, value);
      }
    }
  }
}