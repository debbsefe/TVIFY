import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/theme/theme_shared_preference.dart';
import 'package:movie_colony/core/utils/strings.dart';

class MockThemeSharedPreference extends Mock implements ThemeSharedPreference {}

void main() async {
  late MockThemeSharedPreference pref;

  setUp(() {
    pref = MockThemeSharedPreference();
  });
  group('Custom shared preference test', () {
    test('value should return saved theme', () {
      when(pref.retrieveTheme()).thenReturn(DARK_THEME);

      expect(pref.retrieveTheme(), DARK_THEME);
    });
  });
}
