import 'package:flutter/material.dart';

/// Parent layout: owns the AppBar and BottomNavigationBar, the matched
/// child page is rendered in the body. Pages are built/disposed on navigation.
class AuthShell extends StatelessWidget {
  final Widget child;

  const AuthShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}
