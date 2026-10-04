import 'package:first_app/components/category_list.dart';
import 'package:first_app/components/search_input.dart';
import 'package:flutter/material.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  static const _categories = [
    CategoryItem(label: 'Men', icon: Icons.man),
    CategoryItem(label: 'Women', icon: Icons.woman),
    CategoryItem(label: 'Electrical', icon: Icons.electrical_services),
    CategoryItem(label: 'Hobbies', icon: Icons.sports_esports),
    CategoryItem(label: 'Hobbies', icon: Icons.sports_esports),
    CategoryItem(label: 'Hobbies', icon: Icons.sports_esports),
    CategoryItem(label: 'Hobbies', icon: Icons.sports_esports),
    CategoryItem(label: 'Hobbies', icon: Icons.sports_esports),
  ];
  int _selected = 0;

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
          SizedBox(height: 20),
          Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          CategoryList(
            items: _categories,
            selectedIndex: _selected,
            onSelected: (i) => setState(() => _selected = i),
          ),
        ],
      ),
    );
  }
}
