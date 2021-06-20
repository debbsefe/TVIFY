import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.gr.dart';
import 'core/cache/app_cache.dart';
import 'core/utils/strings.dart';
import 'providers.dart';
import 'service_locator.dart' as di;

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
    Key? key,
  }) : super(key: key);

  final AppCache prefs = di.sl<AppCache>();
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);
    final firstTime = watch(firstTimeProvider);

    var isFirstTimeUser =
        context.read(firstTimeProvider.notifier).currentState();

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MovieColony',
        theme: theme,
        routerDelegate: AutoRouterDelegate.declarative(
          _appRouter,
          routes: (_) => [
            if (isFirstTimeUser && firstTime)
              const OnboardingRoute()
            else
              const HomeScreenTabRoute(),
          ],
        ),
        routeInformationParser:
            _appRouter.defaultRouteParser(includePrefixMatches: true));
  }
}

class FirstTimeNotifier extends StateNotifier<bool> {
  FirstTimeNotifier(this.cache) : super(true);
  final AppCache cache;

  bool currentState() {
    return state;
  }

  void fetchData() {
    var isFirstTime = cache.retrieveBool(Strings.firstTimeUser);

    if (isFirstTime == null) {
      state = true;
    } else {
      state = isFirstTime;
    }
  }

  void addData() {
    state = false;
    cache.saveBool(Strings.firstTimeUser, false);
  }
}
