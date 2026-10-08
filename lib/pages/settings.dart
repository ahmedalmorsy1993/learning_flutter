import 'package:first_app/pages/api.dart';
import 'package:flutter/material.dart';

class Blog {
  final int userId;
  final int id;
  final String title;
  final String body;

  Blog({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body'],
  );
}

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  List<Blog> blogs = [];
  bool loading = true;
  String? error;
  final _listViewController = ScrollController();
  // `late` with an initializer runs getBlogs() once, on first use in build().
  // late Future<List<Blog>> _blogsFuture = getBlogs();

  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
  }

  Future<List<Blog>> getBlogs() async {
    final res = await http.get<List<dynamic>>('/posts');
    return res.data!.map((e) => Blog.fromJson(e)).toList();
  }

  // Future<void> getData() async {
  //   setState(() {
  //     loading = true;
  //     error = null;
  //   });
  //   try {
  //     final response = await http.get<List<dynamic>>('/posts');
  //     final list = response.data!.map((e) => Blog.fromJson(e)).toList();
  //     if (!mounted) return;
  //     setState(() => blogs = list);
  //   } on DioException catch (e) {
  //     if (!mounted) return;
  //     setState(() => error = e.message ?? 'Network error');
  //   } finally {
  //     if (mounted) setState(() => loading = false);
  //   }
  // }

  // The list is built lazily, so maxScrollExtent is only an estimate until the
  // end is laid out: animate close to the end, then jump until it stops growing.
  // Future<void> _scrollToBottom() async {
  //   final c = _listViewController;
  //   await c.animateTo(
  //     c.position.maxScrollExtent,
  //     duration: const Duration(seconds: 1),
  //     curve: Curves.easeOut,
  //   );
  //   while (c.hasClients && c.position.pixels < c.position.maxScrollExtent) {
  //     c.jumpTo(c.position.maxScrollExtent);
  //     await WidgetsBinding.instance.endOfFrame;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Blog>>(
      future: getBlogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load: ${snapshot.error}'),
                TextButton(
                  onPressed: () => getBlogs(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final blogs = snapshot.data!;
        return ListView.builder(
          controller: _listViewController,
          itemCount: blogs.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              minLeadingWidth: 2,
              title: Text(
                blogs[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                blogs[index].body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
