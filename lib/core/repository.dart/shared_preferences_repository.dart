import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  bool isExpired(String key) {
    final String? value = retrieveString(expiryDate(key));
    if (value != null) {
      final currentDate = DateTime.now();
      return currentDate.isAfter(DateTime.parse(value));
    } else {
      return true;
    }
  }

  Future<void> saveString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  String? retrieveString(String key) {
    return sharedPreferences.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  bool? retrieveBool(String key) {
    return sharedPreferences.getBool(key);
  }
}
