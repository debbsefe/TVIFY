import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movie_colony/providers.dart';

import 'core/custom_shared_preference/custom_shared_preference.dart';
import 'core/theme/theme.dart';
import 'core/utils/strings.dart';
import 'features/homescreen/presentation/widgets/homescreen_tab.dart';
import 'features/onboarding/presentation/onboarding.dart';
import 'injection_container.dart' as di;

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

  final CustomSharedPreference prefs = di.sl<CustomSharedPreference>();

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

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MovieColony')),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              context
                  .read(themeProvider.notifier)
                  .changeTheme(CustomTheme.darkThemeData, Strings.darkTheme);
            },
            child: Text(
              'Hello World',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read(themeProvider.notifier)
                  .changeTheme(CustomTheme.lightThemeData, Strings.lightTheme);
            },
            child: Text(
              'Hello Africa',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
