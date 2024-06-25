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
}