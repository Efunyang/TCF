import 'package:echo_frontend/pages/exchange_page/exchange_page.dart';
import 'package:echo_frontend/pages/history_page/history_page.dart';
import 'package:echo_frontend/pages/home_page/home_page.dart';
import 'package:echo_frontend/pages/login_page/login_page.dart';
import 'package:echo_frontend/pages/profile_page/profile_page.dart';
import 'package:echo_frontend/routing/scaffold_with_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AppRoute {
  login,
  home,
  exchange,
  history,
  profile,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  final shellNavigatorExchangeKey = GlobalKey<NavigatorState>(debugLabel: 'shellExchange');
  final shellNavigatorHistoryKey = GlobalKey<NavigatorState>(debugLabel: 'shellHistory');
  final shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  return GoRouter(
    initialLocation: '/login',
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        pageBuilder: (context, state) {
          return const MaterialPage(
            fullscreenDialog: true,
            child: LoginPage(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorExchangeKey,
            routes: [
              GoRoute(
                path: '/exchange',
                name: AppRoute.exchange.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const ExchangePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorHistoryKey,
            routes: [
              GoRoute(
                path: '/history',
                name: AppRoute.history.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const HistoryPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
