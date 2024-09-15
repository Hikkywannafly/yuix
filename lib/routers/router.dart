import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yuix/screens/home/home.dart';
import 'package:yuix/screens/search/search.dart';
import 'package:yuix/widgets/SalomonBottomBar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _mangaNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'manga');
final GlobalKey<NavigatorState> _searchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'search');

final GoRouter router = new GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return BottomNavigation(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              navigatorKey: _homeNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: '/home',
                  builder: (BuildContext context, GoRouterState state) =>
                      const HomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _searchNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: '/search',
                  builder: (BuildContext context, GoRouterState state) =>
                      const SearchScreen(),
                )
              ],
            ),
          ])
    ]);
