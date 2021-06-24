import 'package:flutter/material.dart';

class CustomSnackbar {
  // ignore: always_declare_return_types
  showErrorSnackBar(scaffoldKey, message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('$message', style: const TextStyle(color: Colors.white)));

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // ignore: always_declare_return_types
  showSuccessSnackBar(scaffoldKey, message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('$message', style: const TextStyle(color: Colors.white)));

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // ignore: always_declare_return_types
  showSnackBar(scaffoldKey, message) {
    final snackBar = SnackBar(
        content: Text('$message', style: const TextStyle(color: Colors.white)));

    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
