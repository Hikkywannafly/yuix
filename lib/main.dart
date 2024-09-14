import 'package:flutter/material.dart';
import 'package:yuix/routers/router.dart';
import 'package:yuix/themes/theme.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'YuiX',
      theme: darkMode,
    );
  }
}
