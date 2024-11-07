// app_router.dart
import 'package:go_router/go_router.dart';
import 'package:yuix/screens/home_page.dart';
import 'package:yuix/screens/anime/details_page.dart';
import 'package:yuix/screens/anime/search_page.dart';
import 'package:yuix/screens/manga/details_page.dart';
import 'package:yuix/screens/manga/read_page.dart';
import 'package:yuix/screens/manga/search_page.dart';
import 'package:yuix/screens/user/profile.dart';
import 'package:yuix/screens/anime/home_page.dart';
import 'package:yuix/screens/manga/home_page.dart';
import 'package:yuix/screens/novel/home_page.dart';
import 'package:yuix/routers/main_screen.dart';

class RouterApp {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/anime',
            builder: (context, state) => const AnimeHomePage(),
          ),
          GoRoute(
            path: '/manga',
            builder: (context, state) => const MangaHomePage(),
          ),
          GoRoute(
            path: '/novel',
            builder: (context, state) => const NovelHomePage(),
          ),
        ],
      ),
      // GoRoute(
      //   path: '/details',
      //   builder: (context, state) {
      //     final id = state.queryParameters['id'] ?? '0';
      //     final posterUrl = state.queryParameters['posterUrl'] ?? '';
      //     final tag = state.queryParameters['tag'] ?? '';
      //     return DetailsPage(id: int.parse(id), posterUrl: posterUrl, tag: tag);
      //   },
      // ),
      // GoRoute(
      //   path: '/anime/search',
      //   builder: (context, state) {
      //     final term = state.queryParameters['term'] ?? '';
      //     return SearchPage(searchTerm: term);
      //   },
      // ),
      // GoRoute(
      //   path: '/manga/search',
      //   builder: (context, state) {
      //     final term = state.queryParameters['term'] ?? '';
      //     return MangaSearchPage(searchTerm: term);
      //   },
      // ),
      // GoRoute(
      //   path: '/manga/details',
      //   builder: (context, state) {
      //     final id = state.queryParameters['id'] ?? '';
      //     final posterUrl = state.queryParameters['posterUrl'] ?? '';
      //     final tag = state.queryParameters['tag'] ?? '';
      //     return MangaDetailsPage(id: id, posterUrl: posterUrl, tag: tag);
      //   },
      // ),
      // GoRoute(
      //   path: '/manga/read',
      //   builder: (context, state) {
      //     final id = state.queryParameters['id'] ?? '';
      //     final mangaId = state.queryParameters['mangaId'] ?? '';
      //     final posterUrl = state.queryParameters['posterUrl'] ?? '';
      //     final currentSource = state.queryParameters['currentSource'] ?? '';
      //     return ReadingPage(
      //       id: id,
      //       mangaId: mangaId,
      //       posterUrl: posterUrl,
      //       currentSource: currentSource,
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: '/profile',
      //   builder: (context, state) => const ProfilePage(),
      // ),
    ],
  );
}
