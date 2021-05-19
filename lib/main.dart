import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'core/utils/strings.dart';
import 'features/categories/presentation/notifiers/categories_notifier.dart';
import 'features/categories/presentation/notifiers/categories_state.dart';
import 'features/onboarding/presentation/onboarding.dart';
import 'core/theme/theme.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize dependency injection
  await di.init();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: MovieColony()));
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
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieColony',
        theme: theme,
        home: Onboarding());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MovieColony')),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              context
                  .read(themeProvider.notifier)
                  .changeTheme(CustomTheme.darkThemeData, DARK_THEME);
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
                  .changeTheme(CustomTheme.lightThemeData, LIGHT_THEME);
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
