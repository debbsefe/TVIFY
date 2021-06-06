import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'core/theme/theme.dart';
import 'core/utils/strings.dart';
import 'features/categories/presentation/notifiers/categories_notifier.dart';
import 'features/categories/presentation/notifiers/categories_state.dart';
import 'features/onboarding/presentation/onboarding.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //initialize dependency injection
  await di.init();

  runApp(
    const ProviderScope(
      child: MovieColony(),
    ),
  );
}

//create themeProvider
final themeProvider = StateNotifierProvider<CustomTheme, ThemeData>((ref) {
  return di.sl<CustomTheme>();
});

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  return di.sl<CategoriesNotifier>();
});

class MovieColony extends ConsumerWidget {
  const MovieColony({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieColony',
        theme: theme,
        home: const Onboarding());
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
