import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/utils/custom_shared_preference.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/injection_container.dart' as di;

void main() async {
  CustomSharedPreference prefs;
  await di.init();

  prefs = di.sl<CustomSharedPreference>();

  group('Custom shared preference test', () {
    test('value should return saved theme', () {
      prefs.saveTheme(DARK_THEME);

      expect(prefs.retrieveTheme(), DARK_THEME);
    });
  });
}
