import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:movie_colony/app_router.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final sharedPreferences = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );

  initLogger();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MovieColony(),
    ),
  );
}

class MovieColony extends ConsumerWidget {
  const MovieColony({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final appRouter = ref.watch(appRouterProvider(ref));
    final user = ref.watch(userChangesProvider.stream);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MovieColony',
      theme: theme,
      routerConfig: appRouter.config(
        reevaluateListenable: ReevaluateListenable.stream(user),
      ),
    );
  }
}

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    (record) {
      final log = '[${record.loggerName}] ${record.level.name}: '
          '${record.time}: ${record.message}'
          '${record.stackTrace != null ? '\n${record.stackTrace}' : ''}';

      print(log);
    },
  );
}
