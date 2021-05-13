import 'package:shared_preferences/shared_preferences.dart';

const String THEME = 'theme';

class ThemeSharedPreference {
  final SharedPreferences pref;

  ThemeSharedPreference(this.pref);
  Future<void> saveTheme(String value) async {
    try {
      await pref.setString(THEME, value);
    } catch (e) {
      print(e.toString());
    }
  }

  String? retrieveTheme() {
    String? savedTheme = pref.getString(THEME);
    print('saved theme is $savedTheme');
    return savedTheme;
  }
}
