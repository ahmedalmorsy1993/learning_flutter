import 'package:first_app/pages/aboutus.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:flutter/material.dart';

/// Root screen with a BottomNavigationBar that switches between tabs.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _pages = [NewHomePage(), Aboutus(), Aboutus()];
  static const _navigationItems = [
    BottomNavigationBarItem(
      icon: _DotIcon(Icons.home),
      activeIcon: _DotIcon(Icons.home, active: true),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: _DotIcon(Icons.info),
      activeIcon: _DotIcon(Icons.info, active: true),
      label: 'About',
    ),
    BottomNavigationBarItem(
      icon: _DotIcon(Icons.settings),
      activeIcon: _DotIcon(Icons.settings, active: true),
      label: 'Settings',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps each tab alive, so scroll position and state survive tab switches.
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        // Labels are hidden but still read by screen readers and shown as tooltips.
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _navigationItems,
      ),
    );
  }
}

/// Nav icon with a small dot underneath in place of the text label.
class _DotIcon extends StatelessWidget {
  final IconData icon;
  final bool active;

  const _DotIcon(this.icon, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Icon(icon),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? Colors.deepOrange : Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
