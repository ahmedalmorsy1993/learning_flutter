import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData getThemeData() => ThemeData(
  // fontFamily: "Lumanosimo",
  // Same slide-from-right animation for every page, on every platform.
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      for (final platform in TargetPlatform.values)
        platform: const CupertinoPageTransitionsBuilder(),
    },
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) => const Icon(Icons.chevron_left),
  ),
);
