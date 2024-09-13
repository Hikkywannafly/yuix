import 'package:flutter/material.dart';
import 'package:yuix/routers/router.dart';

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
      // routerDelegate: router.routerDelegate,
      // routeInformationParser: router.routeInformationParser,
      routerConfig: router,
      title: 'YuiX',
      theme: ThemeData(),
    );
  }
}
