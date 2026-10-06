import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('About Us'),
          subtitle: Text('This is the About Us page.'),
        ),
        Center(
          child: MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () => {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  // backgroundColor: Colors.lightBlue,
                  title: const Text('Alert'),
                  content: const Text('This is an alert dialog.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            },
            child: const Text('show alert'),
          ),
        ),
      ],
    );
  }
}
