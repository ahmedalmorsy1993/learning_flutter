import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.grey, width: 0),
  );
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.blueGrey,
        filled: true,
        fillColor: Colors.grey[300],
        enabledBorder: _border,
        focusedBorder: _border,
      ),
    );
  }
}
