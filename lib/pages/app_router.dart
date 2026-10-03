import 'package:first_app/pages/aboutus.dart';
import 'package:first_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => _routePage(state, const HomePage()),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (_, state) => _routePage(state, const Aboutus()),
    ),
  ],
);

CustomTransitionPage<void> _routePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final position = Tween<Offset>(
        begin: const Offset(0.04, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: position, child: child),
      );
    },
  );
}
