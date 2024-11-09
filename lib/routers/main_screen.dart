// main_screen.dart
import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hugeicons/hugeicons.dart';
// import 'package:provider/provider.dart';
// import 'package:yuix/hiveData/themeData/theme_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:yuix/screens/anime/details_page.dart';
import 'package:yuix/screens/anime/search_page.dart';
import 'package:yuix/screens/manga/details_page.dart';
import 'package:yuix/screens/manga/read_page.dart';
import 'package:yuix/screens/manga/search_page.dart';

import 'package:yuix/screens/anime/home_page.dart';
import 'package:yuix/screens/manga/home_page.dart';
import 'package:yuix/screens/home_page.dart';
import 'package:yuix/screens/novel/home_page.dart';
import 'package:yuix/screens/user/settings.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  // final GoRouterState state;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

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
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: routes[_selectedIndex],
      bottomNavigationBar: CrystalNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: _selectedIndex,
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
      ),
    );
  }
}
