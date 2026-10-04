import 'package:first_app/components/search_input.dart';
import 'package:flutter/material.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Home Page')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
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
