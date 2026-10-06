import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  void initState() {
    print('settings initState');
    super.initState();
  }

  @override
  void dispose() {
    print('settings dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(child: Text('settings', style: TextStyle(fontSize: 50))),
    );
  }
}
