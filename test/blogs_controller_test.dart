import 'package:first_app/core/network/app_exception.dart';
import 'package:first_app/features/blogs/data/blog.dart';
import 'package:first_app/features/blogs/data/blog_repository.dart';
import 'package:first_app/features/blogs/presentation/blogs_controller.dart';
import 'package:flutter_test/flutter_test.dart';

// A fake repository: no network, instant and predictable.
// This is only possible because the controller depends on the interface.
class FakeBlogRepository implements BlogRepository {
  FakeBlogRepository({this.blogs = const [], this.error});

  final List<Blog> blogs;
  final AppException? error;

  @override
  Future<List<Blog>> fetchAll() async {
    if (error != null) throw error!;
    return blogs;
  }
}

void main() {
  const blog = Blog(id: 1, userId: 1, title: 'Hello', body: 'World');

  test('starts in loading state', () {
    final controller = BlogsController(FakeBlogRepository());
    expect(controller.state, isA<BlogsLoading>());
  });

  test('load() emits BlogsLoaded with the repository data', () async {
    final controller = BlogsController(FakeBlogRepository(blogs: [blog]));

    await controller.load();

    final state = controller.state as BlogsLoaded;
    expect(state.blogs.single.title, 'Hello');
  });

  test('load() emits BlogsError with a user-friendly message', () async {
    final controller = BlogsController(
      FakeBlogRepository(error: const NetworkException()),
    );

    await controller.load();

    final state = controller.state as BlogsError;
    expect(state.message, contains('No internet'));
  });
}
