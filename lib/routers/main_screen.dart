import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const AppNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return CrystalNavigationBar(
      currentIndex: selectedIndex,
      paddingR: const EdgeInsets.all(10),
      marginR: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      enablePaddingAnimation: true,
      // unselectedItemColor: Colors.white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onTap: onItemTapped,
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
  }
}
