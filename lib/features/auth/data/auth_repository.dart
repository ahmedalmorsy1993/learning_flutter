import 'package:firebase_auth/firebase_auth.dart';

/// Thrown by [AuthRepository]; [message] is safe to show to the user.
class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
}

/// What the app needs, not how it's done. Screens depend on this
/// interface, so tests can pass a fake instead of Firebase.
abstract interface class AuthRepository {
  Future<void> signIn({required String email, required String password});
}

/// The real implementation, backed by Firebase Auth.
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(switch (e.code) {
        'invalid-credential' ||
        'wrong-password' ||
        'user-not-found' => 'Wrong email or password.',
        'invalid-email' => 'Enter a valid email.',
        'user-disabled' => 'This account has been disabled.',
        'too-many-requests' => 'Too many attempts. Try again later.',
        'network-request-failed' => 'No internet connection.',
        _ => 'Login failed. Try again.',
      });
    }
  }
}
