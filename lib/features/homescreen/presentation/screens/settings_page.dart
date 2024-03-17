import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/providers.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool notifications = false;
  bool notifications2 = false;

  Future<void> handleSwitch(bool value) async {
    ref
        .read(themeProvider.notifier)
        .changeTheme(CustomTheme.darkThemeData, Strings.darkTheme);
    setState(() {
      notifications = value;
    });
  }

  Future<void> handleSwitch2(bool value) async {
    ref
        .read(themeProvider.notifier)
        .changeTheme(CustomTheme.lightThemeData, Strings.lightTheme);
    setState(() {
      notifications2 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSwitch(
              value: notifications,
              // ignore: unnecessary_lambdas
              onChanged: (value) => handleSwitch(value),
            ),
            CupertinoSwitch(
              value: notifications2,
              // ignore: unnecessary_lambdas
              onChanged: (value) => handleSwitch2(value),
            ),
          ],
        ),
      ),
    );
  }
}
