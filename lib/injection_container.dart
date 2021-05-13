import 'package:movie_colony/core/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import 'core/theme/theme_shared_preference.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<CustomTheme>(
    () => CustomTheme(sl()),
  );
  sl.registerLazySingleton<ThemeSharedPreference>(
    () => ThemeSharedPreference(sl()),
  );
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
