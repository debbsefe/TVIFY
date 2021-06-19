import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'core/cache/app_cache.dart';
import 'core/utils/strings.dart';
import 'features/homescreen/presentation/screens/homescreen_tab.dart';
import 'features/onboarding/presentation/onboarding.dart';
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

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);
    var isFirstTimeUser = prefs.retrieveBool(Strings.firstTimeUser);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieColony',
        theme: theme,
        home: isFirstTimeUser == null ? const Onboarding() : HomeScreenTab());
  }
}
