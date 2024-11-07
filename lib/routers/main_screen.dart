// main_screen.dart
import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:yuix/hiveData/themeData/theme_provider.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({Key? key, required this.child}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    print(themeProvider.selectedTheme.colorScheme.primary);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: widget.child,
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            selectedColor: themeProvider.selectedTheme.colorScheme.primary,
          ),
          CrystalNavigationBarItem(
            icon: Icons.movie_filter_rounded,
            unselectedIcon: Icons.movie_filter_outlined,
            selectedColor: themeProvider.selectedTheme.colorScheme.primary,
          ),
          CrystalNavigationBarItem(
            icon: Iconsax.book,
            unselectedIcon: Iconsax.book,
            selectedColor: themeProvider.selectedTheme.colorScheme.primary,
          ),
          CrystalNavigationBarItem(
            icon: HugeIcons.strokeRoundedBookOpen01,
            unselectedIcon: HugeIcons.strokeRoundedBookOpen01,
            selectedColor: themeProvider.selectedTheme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
