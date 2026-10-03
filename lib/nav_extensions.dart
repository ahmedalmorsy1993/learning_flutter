import 'package:flutter/material.dart';

extension NavX on BuildContext {
  Future<T?> push<T>(String route, {Object? args}) =>
      Navigator.pushNamed<T>(this, route, arguments: args);
  void go(String route) =>
      Navigator.pushNamedAndRemoveUntil(this, route, (_) => false);
  void pop<T>([T? result]) => Navigator.pop(this, result);
}
