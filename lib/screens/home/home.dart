import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yuix/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:yuix/widgets/home/top_manga.dart';
import 'package:yuix/widgets/home/gender_manga.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Widget _buildContent() {
  //   return const SingleChildScrollView(
  //     child: Padding(
  //       padding: EdgeInsets.all(0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           TopManga(),
  //           Gender(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: ListView(
        children: const [
          TopManga(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Gender(),
          ),
        ],
      ),
    );
  }
  // Widget _buildContent() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const TopManga(),
  //       const SizedBox(height: 20),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         child: const Gender(),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('YuiX'),
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Iconsax.moon : Icons.sunny,
              ),
              onPressed: themeProvider.toggleTheme,
            )
          ],
        ),
        body: _buildContent());
  }
}
