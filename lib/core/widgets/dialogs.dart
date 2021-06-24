import 'package:flutter/material.dart';

Future messageDialog({
  required BuildContext context,
  required VoidCallback onPressed,
  required String content,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Message'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ],
        );
      });
}
