import 'package:movie_colony/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPreference {
  ThemeSharedPreference(this.pref);

  final SharedPreferences pref;

  Future<void> saveTheme(String value) async {
    await pref.setString(Strings.theme, value);
  }

  String? retrieveTheme() {
    String? savedTheme = pref.getString(Strings.theme);
    return savedTheme;
  }
}
