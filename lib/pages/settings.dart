import 'package:first_app/core/dependencies.dart';
import 'package:first_app/features/blogs/data/blog.dart';
import 'package:first_app/features/blogs/data/blog_repository.dart';
import 'package:first_app/features/blogs/presentation/blogs_controller.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  /// [repository] is optional so tests can inject a fake;
  /// the app uses the real one from `dependencies.dart`.
  const Settings({super.key, this.repository});

  final BlogRepository? repository;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final _controller = BlogsController(
    widget.repository ?? blogRepository,
  )..load();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The widget only maps state -> UI. No HTTP, no try/catch, no business logic.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => switch (_controller.state) {
        BlogsLoading() => const Center(child: CircularProgressIndicator()),
        BlogsError(:final message) => _ErrorView(
          message: message,
          onRetry: _controller.load,
        ),
        BlogsLoaded(:final blogs) when blogs.isEmpty => const Center(
          child: Text('No posts yet.'),
        ),
        BlogsLoaded(:final blogs) => RefreshIndicator(
          onRefresh: _controller.refresh,
          child: ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) => _BlogTile(blog: blogs[index]),
          ),
        ),
      },
    );
  }
}

// Small private widgets instead of helper methods: Flutter can rebuild
// them independently, and `const` constructors let it skip rebuilds.

class _BlogTile extends StatelessWidget {
  const _BlogTile({required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          blog.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          blog.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
