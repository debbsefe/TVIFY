import 'package:flutter/material.dart';

mixin CustomSnackbar {
  // ignore: always_declare_return_types
  void showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message, style: const TextStyle(color: Colors.white)),
    );

    showSnack(context, snackBar);
  }

  // ignore: always_declare_return_types
  void showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(message, style: const TextStyle(color: Colors.white)),
    );

    showSnack(context, snackBar);
  }

  // ignore: always_declare_return_types
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
    );

    showSnack(context, snackBar);
  }
}

void showSnack(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
