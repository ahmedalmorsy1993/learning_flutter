import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        // fontFamily: "Lumanosimo",
        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (context) => const Icon(Icons.chevron_left),
        ),
      ),
    );
  }
}
