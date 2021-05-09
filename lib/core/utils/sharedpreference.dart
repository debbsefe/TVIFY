import 'package:shared_preferences/shared_preferences.dart';

const String THEME = 'theme';

class SharedPreference {
  final SharedPreferences prefs;

  SharedPreference(this.prefs);
  Future<void> saveTheme(String value) async {
    try {
      await prefs.setString(THEME, value);
    } catch (e) {
      print(e.toString());
    }
  }

  String? retrieveTheme() {
    String? savedTheme = prefs.getString(THEME);
    print('saved theme is $savedTheme');
    return savedTheme;
  }
}
