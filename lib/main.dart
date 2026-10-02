import 'package:first_app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Employee {
  String firstName;
  String lastName;
  int age;
  Employee({
    required this.firstName,
    required this.lastName,
    required this.age,
  });
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
