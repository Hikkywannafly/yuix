import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigation({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('BottomNavigation'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SalomonBottomBar(
        items: [
          SalomonBottomBarItem(
            icon: Icon(Iconsax.home),
            title: Text('Home'),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Iconsax.search_normal_1),
            title: Text('Search'),
            selectedColor: Colors.red,
          ),
          SalomonBottomBarItem(
            icon: Icon(Iconsax.bookmark),
            title: Text('Bookmark'),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(Iconsax.setting),
            title: Text('Setting'),
            selectedColor: const Color.fromARGB(255, 135, 104, 141),
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => {navigationShell.goBranch(index), print(index)},
        margin: const EdgeInsets.all(18.0),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
