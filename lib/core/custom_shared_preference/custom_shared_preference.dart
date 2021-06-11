import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreference {
  CustomSharedPreference(this.pref);

  final SharedPreferences pref;

  Future<void> saveString(String key, String value) async {
    await pref.setString(key, value);
  }

  String? retrieveString(String key) {
    return pref.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await pref.setBool(key, value);
  }

  bool? retrieveBool(String key) {
    return pref.getBool(key);
  }
}
