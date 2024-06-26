import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvify/app_router.dart';
import 'package:tvify/core/repository.dart/shared_preferences_repository.dart';
import 'package:tvify/core/theme/theme.dart';
import 'package:tvify/providers.dart';

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
      child: const TVify(),
    ),
  );
}

class TVify extends ConsumerWidget {
  const TVify({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider(ref));
    // ignore: deprecated_member_use
    final user = ref.watch(userChangesProvider.stream);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TVify',
      theme: CustomTheme.lightThemeData,
      darkTheme: CustomTheme.darkThemeData,
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

      if (kDebugMode) {
        print(log);
      }
    },
  );
}
