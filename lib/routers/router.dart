import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yuix/screens/home/home.dart';
import 'package:yuix/screens/search/search.dart';
import 'package:yuix/widgets/salomon_bottom_bar.dart';
import 'package:yuix/screens/detail/detail.dart';
import 'package:flutter_animate/flutter_animate.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _searchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'search');

final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return BottomNavigation(
              navigationShell: navigationShell,
              state: state,
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              navigatorKey: _homeNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: '/',
                  builder: (BuildContext context, GoRouterState state) =>
                      _animation(const HomeScreen()),
                ),
                GoRoute(
                  path: '/detail',
                  builder: (BuildContext context, GoRouterState state) =>
                      _animation(const DetailPage(
                    url: '',
                    package: '',
                  )),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _searchNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: '/search',
                  builder: (BuildContext context, GoRouterState state) =>
                      _animation(const SearchScreen()),
                )
              ],
            ),
          ])
    ]);

_animation(Widget child) {
  return Animate(
    child: child,
  ).moveY(
    begin: 40,
    end: 0,
    curve: Curves.easeOutCubic,
  );
}
