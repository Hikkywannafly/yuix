import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yuix/themes/themeProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('YuiX'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Iconsax.moon : Icons.sunny,
            ),
            onPressed: themeProvider.toggleTheme,
          )
        ],
      ),
      body: Container(
        
      )
    );
  }
}
