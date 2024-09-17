import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yuix/routers/router.dart';
import 'package:yuix/themes/theme_provider.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'YuiX',
      theme: themeProvider.currentTheme,
    );
  }
}
