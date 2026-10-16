import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/core/theme/theme_data.dart';
import 'package:first_app/core/ui/app_messenger.dart';
import 'package:first_app/router.dart';
import 'package:first_app/timer_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TimerInfo())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      scaffoldMessengerKey: messengerKey,
      theme: getThemeData(),
    );
  }
}
