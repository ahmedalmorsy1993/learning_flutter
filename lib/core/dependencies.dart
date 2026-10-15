import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/core/network/api_client.dart';
import 'package:first_app/features/auth/data/auth_repository.dart';
import 'package:first_app/features/blogs/data/blog_repository.dart';

// Composition root: the one place that decides which implementations the app
// uses. Everything else receives its dependencies through constructors.
// Packages like get_it or Riverpod replace this file in bigger apps.

final AuthRepository authRepository = FirebaseAuthRepository(
  FirebaseAuth.instance,
);

// Not sending the login token yet: the base URL is a public test API, and
// the token must only go to your own backend. Once it is, use:
// ApiClient(baseUrl: 'https://your-api', token: authRepository.idToken)
final apiClient = ApiClient();

final BlogRepository blogRepository = ApiBlogRepository(apiClient);
