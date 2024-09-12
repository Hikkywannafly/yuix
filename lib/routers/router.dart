import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yuix/screens/index.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _mangaNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'manga');

final GoRouter router = new GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[]);
