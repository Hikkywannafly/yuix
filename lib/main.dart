import 'dart:developer';
import 'package:yuix/auth/auth_provider.dart';
import 'package:yuix/hiveData/appData/database.dart';
import 'package:yuix/screens/novel/home_page.dart';
import 'package:yuix/hiveData/themeData/theme_provider.dart';
import 'package:yuix/screens/anime/home_page.dart';
import 'package:yuix/screens/manga/home_page.dart';
import 'package:yuix/screens/home_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yuix/routers/route.dart';
import 'package:yuix/routers/main_screen.dart';
import 'package:yuix/screens/user/settings.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('login-data');
  await Hive.openBox('app-data');
  try {
    await dotenv.load(fileName: ".env");
    log('Env file loaded successfully.');
  } catch (e) {
    log('Error loading env file: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppData()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (_) => AniListProvider()..tryAutoLogin()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _checkAndroidVersion();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Future<void> _checkAndroidVersion() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final bool isAndroid12orAbove = androidInfo.version.sdkInt >= 31;
    Hive.box('app-data').put('isAndroid12orAbove', isAndroid12orAbove);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final routes = [
    const HomePage(),
    const AnimeHomePage(),
    const MangaHomePage(),
    const NovelHomePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.selectedTheme,
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: routes[_selectedIndex],
        bottomNavigationBar: AppNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
