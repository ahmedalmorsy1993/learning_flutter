import 'package:firebase_auth/firebase_auth.dart';

/// Thrown by [AuthRepository]; [message] is safe to show to the user.
class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
}

/// What the app needs, not how it's done. Screens depend on this
/// interface, so tests can pass a fake instead of Firebase.
abstract interface class AuthRepository {
  /// Firebase keeps the session on the device, so this is already
  /// true on app start when the user logged in before.
  bool get isSignedIn;

  /// Emits whenever the user logs in or out.
  Stream<bool> get signedInChanges;

  /// Current ID token for your own backend; refreshed automatically
  /// when it expires. Null when signed out.
  Future<String?> idToken();

  Future<void> signIn({required String email, required String password});

  /// Creates the account and signs the user in.
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut();
}

/// The real implementation, backed by Firebase Auth.
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  bool get isSignedIn => _auth.currentUser != null;

  @override
  Stream<bool> get signedInChanges =>
      _auth.authStateChanges().map((user) => user != null);

  @override
  Future<String?> idToken() async => _auth.currentUser?.getIdToken();

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> signIn({required String email, required String password}) =>
      _guard(
        () =>
            _auth.signInWithEmailAndPassword(email: email, password: password),
      );

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) => _guard(() async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await result.user?.updateDisplayName(name);
  });

  /// Turns Firebase error codes into messages safe to show the user.
  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on FirebaseAuthException catch (e) {
      throw AuthException(switch (e.code) {
        'invalid-credential' ||
        'wrong-password' ||
        'user-not-found' => 'Wrong email or password.',
        'email-already-in-use' => 'An account with this email already exists.',
        'weak-password' => 'Password is too weak.',
        'invalid-email' => 'Enter a valid email.',
        'user-disabled' => 'This account has been disabled.',
        'too-many-requests' => 'Too many attempts. Try again later.',
        'network-request-failed' => 'No internet connection.',
        // Firebase Console setup problems (the developer's, not the user's).
        'operation-not-allowed' => 'Email sign-in is not enabled for this app.',
        _ when e.message?.contains('CONFIGURATION_NOT_FOUND') ?? false =>
          'Firebase Authentication is not set up for this app.',
        _ => 'Something went wrong. Try again.',
      });
    }
  }
}
