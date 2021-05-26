import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/theme/theme_shared_preference.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() async {
  late MockSharedPreference mockPref;
  late ThemeSharedPreference theme;

  setUp(() {
    mockPref = MockSharedPreference();
    theme = ThemeSharedPreference(mockPref);
  });

  group('Save Theme test', () {
    test('should save theme when saveTheme method is called', () {
      theme.saveTheme(DARK_THEME);

      verify(mockPref.setString(
        THEME,
        DARK_THEME,
      ));
    });
  });
  group('Retrieve Theme test', () {
    test('should return saved theme', () {
      when(theme.retrieveTheme()).thenReturn(DARK_THEME);

      expect(theme.retrieveTheme(), DARK_THEME);
    });

    test('should return null when no theme is saved', () {
      when(theme.retrieveTheme()).thenReturn(null);

      expect(theme.retrieveTheme(), null);
    });
  });
}
