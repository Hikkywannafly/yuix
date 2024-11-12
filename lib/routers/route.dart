import 'package:flutter/material.dart';
import 'package:yuix/screens/anime/details_page.dart';
import 'package:yuix/screens/anime/search_page.dart';
import 'package:yuix/screens/manga/details_page.dart';
import 'package:yuix/screens/manga/read_page.dart';
import 'package:yuix/screens/manga/search_page.dart';
import 'package:yuix/screens/user/profile.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case '/details':
        final posterUrl = args?['posterUrl'] ?? '';
        final id = args?['id'] ?? 0;
        final tag = args?['tag'] ?? '';
        return MaterialPageRoute(
          builder: (context) => DetailsPage(
            id: id,
            posterUrl: posterUrl,
            tag: tag,
          ),
        );
      case '/anime/search':
        final id = args?['term'] ?? '';
        return MaterialPageRoute(
          builder: (context) => SearchPage(searchTerm: id),
        );
      case '/manga/search':
        final id = args?['term'] ?? '';
        return MaterialPageRoute(
          builder: (context) => MangaSearchPage(searchTerm: id),
        );
      case '/manga/details':
        final posterUrl = args?['posterUrl'] ?? '';
        final id = args?['id'] ?? '';
        final tag = args?['tag'] ?? '';
        return MaterialPageRoute(
          builder: (context) =>
              MangaDetailsPage(id: id, posterUrl: posterUrl, tag: tag),
        );
      case '/manga/read':
        final id = args?['id'] ?? '';
        final mangaId = args?['mangaId'] ?? '';
        final posterUrl = args?['posterUrl'] ?? '';
        final currentSource = args?['currentSource'] ?? '';
        final anilistId = args?['anilistId'] ?? '';
        return MaterialPageRoute(
          builder: (context) => ReadingPage(
            id: id,
            mangaId: mangaId,
            posterUrl: posterUrl,
            currentSource: currentSource,
            anilistId: anilistId,
          ),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
