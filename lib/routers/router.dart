import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yuix/screens/index.dart';
import 'package:yuix/widgets/SalomonBottomBar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _mangaNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'manga');

final GoRouter router = new GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) =>
            const BottomNavigation(child: HomeScreen()),
      ),
    ]);
