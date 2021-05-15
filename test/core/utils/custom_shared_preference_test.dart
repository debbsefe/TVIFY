import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/theme/theme_shared_preference.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/injection_container.dart' as di;

void main() async {
  ThemeSharedPreference pref;
  await di.init();

  pref = di.sl<ThemeSharedPreference>();

  group('Custom shared preference test', () {
    test('value should return saved theme', () {
      pref.saveTheme(DARK_THEME);

      expect(pref.retrieveTheme(), DARK_THEME);
    });
  });
}
