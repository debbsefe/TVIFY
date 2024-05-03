import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final sharedPreferencesRepositoryProvider = Provider(
  (ref) => SharedPreferencesRepository(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  ),
);

class SharedPreferencesRepository {
  SharedPreferencesRepository({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  final String _theme = Strings.theme;
  final String _firstTimeUser = Strings.firstTimeUser;
  final String _lastCacheDate = Strings.lastCacheDate;
  final String _categoryCache = Strings.cachedCategory;
  final String _configurationCache = Strings.cachedConfiguration;

  Future<void> setThemePreference(ThemeType value) async {
    await sharedPreferences.setString(_theme, value.name);
  }

  ThemeType getThemePreference() {
    final theme = sharedPreferences.getString(_theme);
    return ThemeType.values.firstWhere(
      (e) => e.name == theme,
      orElse: () => ThemeType.light,
    );
  }

  Future<void> setFirstTimeUser() async {
    await sharedPreferences.setBool(_firstTimeUser, false);
  }

  bool getFirstTimeUser() {
    return sharedPreferences.getBool(_firstTimeUser) ?? false;
  }

  bool shouldRenewCache(String key) {
    final String? value = sharedPreferences.getString(_lastCacheDate + key);
    if (value != null) {
      final currentDate = DateTime.now();
      return currentDate.isAfter(DateTime.parse(value));
    } else {
      return true;
    }
  }

  Future<void> setLastCacheDate(String key) async {
    final String sevenDaysLater =
        DateTime.now().add(const Duration(days: 7)).toIso8601String();
    await sharedPreferences.setString(_lastCacheDate + key, sevenDaysLater);
  }

  Future<void> setCategoryCache(CategoriesModel value) async {
    await sharedPreferences.setString(
      _categoryCache,
      categoriesModelToJson(value),
    );
    await setLastCacheDate(_categoryCache);
  }

  String? getCategoryCache() {
    return sharedPreferences.getString(_categoryCache);
  }

  Future<void> setConfigurationCache(ConfigurationModel value) async {
    await sharedPreferences.setString(
      _configurationCache,
      configurationModelToJson(value),
    );
    await setLastCacheDate(_configurationCache);
  }

  String? getConfigurationCache() {
    return sharedPreferences.getString(_configurationCache);
  }
}
