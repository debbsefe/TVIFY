import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/strings.dart';
import '../../../../providers.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool notifications = false;
  bool notifications2 = false;

  void handleSwitch(bool value) async {
    context
        .read(themeProvider.notifier)
        .changeTheme(CustomTheme.darkThemeData, Strings.darkTheme);
    setState(() {
      notifications = value;
    });
  }

  void handleSwitch2(bool value) async {
    context
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
    ));
  }
}
