import 'package:first_app/core/network/app_exception.dart';
import 'package:first_app/features/blogs/data/blog.dart';
import 'package:first_app/features/blogs/data/blog_repository.dart';
import 'package:flutter/foundation.dart';

/// Every state the screen can be in. Because it's sealed, the UI's
/// `switch` won't compile if a state is forgotten.
sealed class BlogsState {
  const BlogsState();
}

final class BlogsLoading extends BlogsState {
  const BlogsLoading();
}

final class BlogsLoaded extends BlogsState {
  const BlogsLoaded(this.blogs);
  final List<Blog> blogs;
}

final class BlogsError extends BlogsState {
  const BlogsError(this.message);
  final String message;
}

/// Holds the screen's logic and state; the widget only renders [state].
class BlogsController extends ChangeNotifier {
  BlogsController(this._repository);

  final BlogRepository _repository;
  bool _disposed = false;

  BlogsState _state = const BlogsLoading();
  BlogsState get state => _state;

  /// First load, or retry after an error: shows the full-screen spinner.
  Future<void> load() async {
    _emit(const BlogsLoading());
    await _fetch();
  }

  /// Pull-to-refresh: keeps the current list visible while fetching.
  Future<void> refresh() => _fetch();

  Future<void> _fetch() async {
    try {
      _emit(BlogsLoaded(await _repository.fetchAll()));
    } on AppException catch (e) {
      _emit(BlogsError(e.message));
    }
  }

  // The request can finish after the user has left the screen;
  // notifying a disposed ChangeNotifier throws.
  void _emit(BlogsState next) {
    if (_disposed) return;
    _state = next;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
