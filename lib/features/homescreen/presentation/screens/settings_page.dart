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

  // ignore: avoid_positional_boolean_parameters
  void onPushNotificationChanged(bool value) {
    setState(() {
      notifications = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text('About'),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () async {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return const AboutDialog(
                        applicationVersion: '1.0.0',
                        applicationLegalese: '© 2024 TvFiy',
                      );
                    },
                  );
                },
              ),
              const ListTile(
                title: Text('Share'),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
              const ListTile(
                title: Text('Create Account'),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
              ListTile(
                title: const Text('Push Notifications'),
                trailing: CupertinoSwitch(
                  value: notifications,
                  onChanged: onPushNotificationChanged,
                ),
              ),
              ListTile(
                title: const Text('Sign Out'),
                onTap: () {
                  ref.watch(firebaseAuthProvider).signOut();
                },
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
