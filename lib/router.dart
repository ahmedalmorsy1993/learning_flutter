import 'package:first_app/components/products.dart';
import 'package:first_app/pages/aboutus.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/main_shell.dart';
import 'package:first_app/pages/product_details.dart';
import 'package:first_app/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/',
  routes: [
    // Layout route: MainShell renders the shared AppBar + bottom bar and
    // places the matched child page in its body (like <Outlet/> / <slot/>).
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) =>
          MainShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(path: '/', builder: (_, _) => const NewHomePage()),
        GoRoute(path: '/about', builder: (_, _) => const Aboutus()),
        GoRoute(path: '/settings', builder: (_, _) => const Settings()),
      ],
    ),
    // Outside the shell (root navigator) so it covers the bottom bar.
    GoRoute(
      path: '/product',
      parentNavigatorKey: _rootKey,
      builder: (_, state) => ProductDetails(product: state.extra! as Product),
    ),
  ],
);
