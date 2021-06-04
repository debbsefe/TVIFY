import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreference {
  CustomSharedPreference(this.pref);

  final SharedPreferences pref;

  Future<void> saveData(String key, String value) async {
    await pref.setString(key, value);
  }

  String? retrieveData(String key) {
    String? savedTheme = pref.getString(key);
    return savedTheme;
  }
}
