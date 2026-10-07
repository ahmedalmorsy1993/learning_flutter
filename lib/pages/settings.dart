import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  late ScrollController _listViewController;
  @override
  void initState() {
    _listViewController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
  }

  // The list is built lazily, so maxScrollExtent is only an estimate until the
  // end is laid out: animate close to the end, then jump until it stops growing.
  Future<void> _scrollToBottom() async {
    final c = _listViewController;
    await c.animateTo(
      c.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
    while (c.hasClients && c.position.pixels < c.position.maxScrollExtent) {
      c.jumpTo(c.position.maxScrollExtent);
      await WidgetsBinding.instance.endOfFrame;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _listViewController,
      children: [
        IconButton(
          onPressed: _scrollToBottom,
          icon: Icon(Icons.arrow_downward, size: 40, color: Colors.red),
        ),
        ...List.generate(
          1000,
          (index) => Container(
            color: index.isEven ? Colors.red : Colors.green,
            height: 200,
            alignment: Alignment.center,
            child: Text(
              index.toString(),
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
        ),
        IconButton(
          onPressed: () => _listViewController.animateTo(
            _listViewController.position.minScrollExtent,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          ),
          icon: Icon(Icons.arrow_upward, size: 40, color: Colors.green),
        ),
      ],
    );
  }
}
