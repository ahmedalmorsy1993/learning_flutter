import 'package:first_app/components/search_input.dart';
import 'package:flutter/material.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            const Text(
              'Gipsy',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Bee',
              style: TextStyle(
                fontSize: 25,

                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Row(
            spacing: 20,
            children: [
              Expanded(child: SearchInput()),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
