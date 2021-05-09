import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/strings.dart';
import 'theme.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize dependency injection
  await di.init();
  runApp(ProviderScope(child: MovieColony()));
}

final themeProvider = StateNotifierProvider<CustomTheme, ThemeData>((ref) {
  return di.sl<CustomTheme>();
});

class MovieColony extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);

    return MaterialApp(title: 'MovieColony', theme: theme, home: Home());
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
              var color = Theme.of(context).textTheme.bodyText1;
              if (color != null) print(color.fontSize);
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
              var color = Theme.of(context).textTheme.bodyText1;
              if (color != null) print(color.fontSize);
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
