import 'package:first_app/core/network/api_client.dart';
import 'package:first_app/features/blogs/data/blog.dart';

/// What the app needs, not how it's done. Screens and controllers depend on
/// this interface, so tests can pass a fake that returns canned data.
abstract interface class BlogRepository {
  Future<List<Blog>> fetchAll();
}

/// The real implementation, backed by the REST API.
class ApiBlogRepository implements BlogRepository {
  ApiBlogRepository(this._api);

  final ApiClient _api;

  @override
  Future<List<Blog>> fetchAll() async {
    final json = await _api.get<List<dynamic>>('/posts');
    return json
        .map((item) => Blog.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
