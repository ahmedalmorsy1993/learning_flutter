import 'package:flutter/material.dart';

/// Lets code without a [BuildContext] (like a Dio interceptor) show
/// SnackBars. Wired to the app via `MaterialApp.scaffoldMessengerKey`.
final messengerKey = GlobalKey<ScaffoldMessengerState>();

abstract final class AppMessenger {
  static void success(String message) => _show(message, Colors.green);

  static void error(String message) => _show(message, Colors.red);

  static void _show(String message, Color color) {
    messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
