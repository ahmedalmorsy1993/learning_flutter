import 'package:first_app/pages/aboutus.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:flutter/material.dart';

/// Root screen with a bottom NavigationBar that switches between tabs.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _pages = [NewHomePage(), Aboutus(), Aboutus()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps each tab alive, so scroll position and state survive tab switches.
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'About Us',
          ),
          NavigationDestination(icon: Icon(Icons.info), label: 'About Us'),
        ],
      ),
    );
  }
}
