// app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:path/path.dart';
import 'package:yuix/screens/home_page.dart';
import 'package:yuix/screens/anime/details_page.dart';
import 'package:yuix/screens/anime/search_page.dart';
import 'package:yuix/screens/manga/details_page.dart';
import 'package:yuix/screens/manga/read_page.dart';
import 'package:yuix/screens/manga/search_page.dart';
import 'package:yuix/screens/user/anilist_pages/anime_list.dart';
import 'package:yuix/screens/user/profile.dart';
import 'package:yuix/screens/anime/home_page.dart';
import 'package:yuix/screens/manga/home_page.dart';
import 'package:yuix/screens/novel/home_page.dart';
import 'package:yuix/routers/main_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:yuix/screens/user/settings.dart';

// class RouterApp {
//   static final GoRouter router = GoRouter(
//     initialLocation: '/',
//     routes: <RouteBase>[
//       ShellRoute(
//         builder: (context, state, child) => MainScreen(child: child),
//         routes: [
//           GoRoute(
//             path: '/',
//             builder: (context, state) => const HomePage(),
//           ),
//           GoRoute(
//             path: '/anime',
//             builder: (context, state) => const AnimeHomePage(),
//           ),
//           GoRoute(
//             path: '/manga',
//             builder: (context, state) => const MangaHomePage(),
//           ),
//           GoRoute(
//             path: '/novel',
//             builder: (context, state) => const NovelHomePage(),
//           ),
//         ],
//       ),
//       GoRoute(
//         path: '/details',
//         builder: (context, state) {
//           final id = state.queryParameters['id'] ?? '0';
//           final posterUrl = state.queryParameters['posterUrl'] ?? '';
//           final tag = state.queryParameters['tag'] ?? '';
//           return DetailsPage(id: int.parse(id), posterUrl: posterUrl, tag: tag);
//         },
//       ),
//       GoRoute(
//         path: '/anime/search',
//         builder: (context, state) {
//           final term = state.queryParameters['term'] ?? '';
//           return SearchPage(searchTerm: term);
//         },
//       ),
//       GoRoute(
//         path: '/manga/search',
//         builder: (context, state) {
//           final term = state.queryParameters['term'] ?? '';
//           return MangaSearchPage(searchTerm: term);
//         },
//       ),
//       GoRoute(
//         path: '/manga/details',
//         builder: (context, state) {
//           final id = state.queryParameters['id'] ?? '';
//           final posterUrl = state.queryParameters['posterUrl'] ?? '';
//           final tag = state.queryParameters['tag'] ?? '';
//           return MangaDetailsPage(id: id, posterUrl: posterUrl, tag: tag);
//         },
//       ),
//       GoRoute(
//         path: '/manga/read',
//         builder: (context, state) {
//           final id = state.queryParameters['id'] ?? '';
//           final mangaId = state.queryParameters['mangaId'] ?? '';
//           final posterUrl = state.queryParameters['posterUrl'] ?? '';
//           final currentSource = state.queryParameters['currentSource'] ?? '';
//           return ReadingPage(
//             id: id,
//             mangaId: mangaId,
//             posterUrl: posterUrl,
//             currentSource: currentSource,
//           );
//         },
//       ),
//       GoRoute(
//         path: '/profile',
//         builder: (context, state) => const ProfilePage(),
//       ),
//     ],
//   );
// }

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

BuildContext get currentContext {
  return _shellNavigatorKey.currentContext!;
}

final GoRouter router = GoRouter(routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => _animation(const HomePage()),
        ),
        GoRoute(
          path: '/anime',
          builder: (context, state) => _animation(const AnimeHomePage()),
        ),
        GoRoute(
          path: '/manga',
          builder: (context, state) => _animation(const MangaHomePage()),
        ),
        GoRoute(
          path: '/novel',
          builder: (context, state) => _animation(const NovelHomePage()),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => _animation(const SettingsPage()),
        ),
        GoRoute(
          path: '/details',
          builder: (context, state) {
            final id = state.uri.queryParameters['id'] ?? '0';
            final posterUrl = state.uri.queryParameters['posterUrl'] ?? '';
            final tag = state.uri.queryParameters['tag'] ?? '';
            return DetailsPage(
                id: int.parse(id), posterUrl: posterUrl, tag: tag);
          },
        ),
        GoRoute(path: '/anime-list', builder: (context, state) => AnimeList()),
        GoRoute(
          path: '/anime/search',
          builder: (context, state) {
            final term = state.uri.queryParameters['term'] ?? '';
            return SearchPage(searchTerm: term);
          },
        ),
        GoRoute(
          path: '/manga/search',
          builder: (context, state) {
            final term = state.uri.queryParameters['term'] ?? '';
            return MangaSearchPage(searchTerm: term);
          },
        ),
        GoRoute(
          path: '/manga/details',
          builder: (context, state) {
            final id = state.uri.queryParameters['id'] ?? '';
            final posterUrl = state.uri.queryParameters['posterUrl'] ?? '';
            final tag = state.uri.queryParameters['tag'] ?? '';
            print('id: $id, posterUrl: $posterUrl, tag: $tag');
            return MangaDetailsPage(id: id, posterUrl: posterUrl, tag: tag);
          },
        ),
        GoRoute(
          path: '/manga/read',
          builder: (context, state) {
            final id = state.uri.queryParameters['id'] ?? '';
            final mangaId = state.uri.queryParameters['mangaId'] ?? '';
            final posterUrl = state.uri.queryParameters['posterUrl'] ?? '';
            final currentSource =
                state.uri.queryParameters['currentSource'] ?? '';
            return ReadingPage(
              id: id,
              mangaId: mangaId,
              posterUrl: posterUrl,
              currentSource: currentSource,
            );
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ])
]);

_animation(Widget child) {
  return Animate(
    child: child,
  ).moveY(
    begin: 50,
    end: 0,
    curve: Curves.easeInOut,
  );
}
