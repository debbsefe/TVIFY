import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_colony/app_router.gr.dart';
import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/providers.dart';
import 'package:movie_colony/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //initialize dependency injection
  await di.init();

  runApp(
    ProviderScope(
      child: MovieColony(),
    ),
  );
}

class MovieColony extends ConsumerWidget {
  MovieColony({
    super.key,
  });

  final AppCache prefs = di.sl<AppCache>();
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final isFirstTime = prefs.retrieveBool(Strings.firstTimeUser);
    final user = ref.watch(userChangesProvider).value;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MovieColony',
      theme: theme,
      routerDelegate: AutoRouterDelegate.declarative(
        _appRouter,
        routes: (_) => [
          if (isFirstTime == null)
            const OnboardingRoute()
          else if (user == null)
            const SignUpPageRoute()
          else
            const HomeScreenTabRoute(),
        ],
      ),
      routeInformationParser:
          _appRouter.defaultRouteParser(includePrefixMatches: true),
    );
  }
}
