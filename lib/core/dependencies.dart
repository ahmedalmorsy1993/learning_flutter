import 'package:first_app/core/network/api_client.dart';
import 'package:first_app/features/blogs/data/blog_repository.dart';

// Composition root: the one place that decides which implementations the app
// uses. Everything else receives its dependencies through constructors.
// Packages like get_it or Riverpod replace this file in bigger apps.

final apiClient = ApiClient();

final BlogRepository blogRepository = ApiBlogRepository(apiClient);
