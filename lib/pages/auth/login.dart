import 'package:first_app/components/back_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const new({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [OutlinedBackButton()],
          ),
        ],
      ),
    );
  }
}
