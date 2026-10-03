import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   tooltip: 'Back',
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     if (context.canPop()) {
        //       context.pop();
        //     } else {
        //       context.go('/home');
        //     }
        //   },
        // ),
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Text(
          'This is the About Us page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
