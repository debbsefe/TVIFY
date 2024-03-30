import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/providers.dart';

@RoutePage()
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
        .changeTheme(CustomTheme.darkThemeData, ThemeType.dark);
    setState(() {
      notifications = value;
    });
  }

  Future<void> handleSwitch2(bool value) async {
    ref
        .read(themeProvider.notifier)
        .changeTheme(CustomTheme.lightThemeData, ThemeType.light);
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
              onChanged: handleSwitch,
            ),
            CupertinoSwitch(
              value: notifications2,
              onChanged: handleSwitch2,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                ref.watch(firebaseAuthProvider).signOut();
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
