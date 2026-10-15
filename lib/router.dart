import 'dart:async';

import 'package:first_app/components/products.dart';
import 'package:first_app/core/dependencies.dart';
import 'package:first_app/pages/aboutus.dart';
import 'package:first_app/pages/auth/login.dart';
import 'package:first_app/pages/auth/signup.dart';
import 'package:first_app/pages/google_map.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/main_shell.dart';
import 'package:first_app/pages/product_details.dart';
import 'package:first_app/pages/settings.dart';
import 'package:first_app/shells/auth_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();
final _authShellKey = GlobalKey<NavigatorState>();

const _authPaths = {'/login', '/signup'};

/// go_router 18 only animates pages when it finds `material_ui`'s
/// MaterialApp; this app uses Flutter's, so go_router would show every page
/// without a transition. Building the MaterialPage ourselves brings back the
/// theme's page animation (`pageTransitionsTheme` in main.dart).
Page<void> _page(GoRouterState state, Widget child) =>
    MaterialPage(key: state.pageKey, child: child);

/// A bottom-bar tab. Tab pages have no background of their own, so the
/// old tab would show through the new one while it slides in; painting the
/// scaffold color behind each tab makes it opaque.
GoRoute _tab(String path, Widget page) => GoRoute(
  path: path,
  pageBuilder: (context, state) => _page(
    state,
    ColoredBox(color: Theme.of(context).scaffoldBackgroundColor, child: page),
  ),
);

/// A [GoRoute] that uses [_page]: one line per route.
GoRoute _route(
  String path,
  Widget Function(GoRouterState state) page, {
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) => GoRoute(
  path: path,
  parentNavigatorKey: parentNavigatorKey,
  pageBuilder: (_, state) => _page(state, page(state)),
);

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  // Re-runs [redirect] whenever the user logs in or out.
  refreshListenable: _StreamListenable(authRepository.signedInChanges),
  redirect: (context, state) {
    final onAuthPage = _authPaths.contains(state.matchedLocation);
    if (!authRepository.isSignedIn && !onAuthPage) return '/login';
    if (authRepository.isSignedIn && onAuthPage) return '/';
    return null;
  },
  routes: [
    // Layout route: MainShell renders the shared AppBar + bottom bar and
    // places the matched child page in its body (like <Outlet/> / <slot/>).
    ShellRoute(
      navigatorKey: _shellKey,
      pageBuilder: (_, state, child) =>
          _page(state, MainShell(location: state.uri.path, child: child)),
      routes: [
        _tab('/', const NewHomePage()),
        _tab('/about', const Aboutus()),
        _tab('/settings', const Settings()),
        _tab('/google-map', const MapSample()),
      ],
    ),
    // Auth pages share AuthShell's layout.
    ShellRoute(
      navigatorKey: _authShellKey,
      pageBuilder: (_, state, child) => _page(state, AuthShell(child: child)),
      routes: [
        _route('/login', (_) => const Login()),
        _route('/signup', (_) => const Signup()),
      ],
    ),

    // Outside the shell (root navigator) so it covers the bottom bar.
    _route(
      '/product',
      (state) => ProductDetails(product: state.extra! as Product),
      parentNavigatorKey: _rootKey,
    ),
  ],
);

/// Adapts a [Stream] to the [Listenable] that `refreshListenable` expects.
class _StreamListenable extends ChangeNotifier {
  _StreamListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
