import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yuix/common/results_list.dart';
import 'package:yuix/data/providers/anilist/anilist_providers.dart';
import 'package:yuix/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:yuix/screens/home/top_manga.dart';
import 'package:yuix/data/providers/anilist/queries.dart';
import 'package:yuix/widgets/media_item_card.dart';
import 'package:yuix/widgets/cover.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildContent() {
    return ListView(children: [
      // Cover(
      //   alt: 'http://via.placeholder.com/350x150',
      //   url:
      //       'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      // ),
      // MediaItemCard(
      //   title: 'sd',
      //   cover:
      //       'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      //   url:
      //       'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      // ),
      // const TopManga(),
      MeidaList(
        mainTitle: 'All the time popular',
        query: upcommingNextSeasonquery,
        variables: returnQuery(1, 'trending', AnilistType.manga),
      ),
      // MeidaList(
      //   mainTitle: 'Popular Manhwa',
      //   query: top100MediaQuery,
      //   variables: popularManhwaQueryVariables,
      // ),
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
