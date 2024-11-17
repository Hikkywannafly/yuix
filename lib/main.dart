import 'dart:developer';
import 'package:yuix/auth/auth_provider.dart';
import 'package:yuix/hiveData/appData/database.dart';
import 'package:yuix/hiveData/locale_provider.dart';
import 'package:yuix/routers/route.dart';
import 'package:yuix/screens/Novel/home_page.dart';
import 'package:yuix/hiveData/themeData/theme_provider.dart';
import 'package:yuix/screens/Anime/home_page.dart';
import 'package:yuix/screens/Manga/home_page.dart';
import 'package:yuix/screens/home_page.dart';
import 'package:yuix/screens/user/settings.dart';
import 'package:yuix/utils/i18n.dart';
import 'package:yuix/utils/sources/anime/handler/sources_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconsax/iconsax.dart';

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
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => SourcesHandler()),
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
    final localeProvider = Provider.of<LocaleProvider>(context);
    final box = Hive.box('app-data');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.selectedTheme,
      locale: localeProvider.locale,
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: routes[_selectedIndex],
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (BuildContext context, Box<dynamic> value, Widget? child) {
            return CrystalNavigationBar(
              borderRadius: box.get('tabBarRoundness', defaultValue: 30.0),
              currentIndex: _selectedIndex,
              paddingR: const EdgeInsets.all(0),
              marginR: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onTap: _onItemTapped,
              items: [
                CrystalNavigationBarItem(
                  icon: Iconsax.home,
                  unselectedIcon: Iconsax.home,
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
                CrystalNavigationBarItem(
                  icon: Iconsax.video_play,
                  unselectedIcon: Iconsax.video_play,
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
                CrystalNavigationBarItem(
                  icon: Iconsax.book,
                  unselectedIcon: Iconsax.book,
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
                CrystalNavigationBarItem(
                  icon: HugeIcons.strokeRoundedBookOpen01,
                  unselectedIcon: HugeIcons.strokeRoundedBookOpen01,
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
                CrystalNavigationBarItem(
                  icon: Iconsax.setting,
                  unselectedIcon: Iconsax.setting,
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            );
          },
        ),
      ),
      localizationsDelegates: I18nUtil.getLocalizationDelegates(),
      supportedLocales: I18nUtil.getSupportedLocales(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
