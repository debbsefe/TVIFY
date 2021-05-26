import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreference {
  final SharedPreferences pref;

  CustomSharedPreference(this.pref);
  Future<void> saveData(String key, String value) async {
    try {
      await pref.setString(key, value);
    } catch (e) {
      print(e.toString());
    }
  }

  String? retrieveData(String key) {
    String? savedTheme = pref.getString(key);
    print('saved key is $key');
    return savedTheme;
  }
}
