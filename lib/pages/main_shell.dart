import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _Tab {
  final String path;
  final IconData icon;
  final String label;
  final Widget? title;

  const _Tab(this.path, this.icon, this.label, [this.title]);
}

/// Parent layout: owns the AppBar and BottomNavigationBar, the matched
/// child page is rendered in the body. Pages are built/disposed on navigation.
class MainShell extends StatelessWidget {
  final String location;
  final Widget child;

  const MainShell({super.key, required this.location, required this.child});

  static const _tabs = [
    _Tab('/', Icons.home, 'Home', _Logo()),
    _Tab('/about', Icons.info, 'About Us'),
    _Tab('/settings', Icons.settings, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final index = _tabs.indexWhere((t) => t.path == location).clamp(0, 2);
    final tab = _tabs[index];

    return Scaffold(
      appBar: AppBar(
        title: tab.title ?? Text(tab.label),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) => print(value),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'first Value', child: Text('First')),
              PopupMenuItem(value: 'second Value', child: Text('second')),
            ],
          ),
          IconButton(
            onPressed: () => {
              showSearch(context: context, delegate: _CustomSearch()),
            },
            icon: Icon(Icons.search, size: 30),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: index,
        onTap: (i) => context.go(_tabs[i].path),
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        // Labels are hidden but still read by screen readers and shown as tooltips.
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          for (final (i, t) in _tabs.indexed)
            BottomNavigationBarItem(
              icon: _DotIcon(t.icon, active: i == index),
              label: t.label,
            ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        Text(
          'Gipsy',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          'Bee',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrangeAccent,
          ),
        ),
      ],
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

class _CustomSearch extends SearchDelegate {
  final List<String> _names = ['ahmed', 'ismail', 'almorsy', "ali"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => super.query = '', icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => super.close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(super.query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matched = _names
        .where((element) => element.contains(super.query.trim()))
        .toList();
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: matched.length,
        itemBuilder: (context, i) => TextButton(
          style: ButtonStyle(
            alignment: Alignment.topLeft,
            elevation: WidgetStatePropertyAll(2),
            // backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) return Colors.black45;
              if (states.contains(WidgetState.disabled)) return Colors.grey;
              return Colors.grey.shade200;
            }),
          ),

          onPressed: () => super.query = matched[i],
          child: Text(matched[i]),
        ),
      ),
    );
  }
}
