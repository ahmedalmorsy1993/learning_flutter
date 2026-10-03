import 'package:first_app/nav_extensions.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: ListView(
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
                        onPressed: () => context.pop(),
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
      ),
    );
  }
}
