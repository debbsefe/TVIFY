import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSwitch(
              value: notifications,
              onChanged: (value) {},
            ),
            CupertinoSwitch(
              value: notifications2,
              onChanged: (value) {},
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
