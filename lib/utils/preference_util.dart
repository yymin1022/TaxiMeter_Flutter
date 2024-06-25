import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  PreferenceUtil._privateConstructor();
  static final PreferenceUtil _instance = PreferenceUtil._privateConstructor();

  factory PreferenceUtil() {
    return _instance;
  }

  SharedPreferences? prefs;

  Future<void> initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<String?> getPrefsValue(String key) async {
    if(prefs != null) {
      return prefs!.getString(key);
    }
    
    return null;
  }
}