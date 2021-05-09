import 'package:movie_colony/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/sharedpreference.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<CustomTheme>(
    () => CustomTheme(sl()),
  );
  sl.registerLazySingleton<SharedPreference>(
    () => SharedPreference(sl()),
  );
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
