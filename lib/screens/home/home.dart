import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yuix/common/results_list.dart';
// import 'package:yuix/models/media.dart';
import 'package:yuix/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:yuix/widgets/home/top_manga.dart';
import 'package:yuix/data/providers/anilist/queries.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildContent() {
    return ListView(children: [
      const TopManga(),
      AnimeList(
        mainTitle: 'Trending Anime',
        query: upcommingNextSeasonquery,
        variables: 'ANIME',
      ),
      AnimeList(
        mainTitle: 'Trending Anime',
        query: upcommingNextSeasonquery,
        variables: 'ANIME',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('YuiX'),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
