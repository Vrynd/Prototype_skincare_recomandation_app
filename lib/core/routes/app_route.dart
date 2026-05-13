import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_recomendation/features/auth/presentation/screens/login_screen.dart';
import 'package:skincare_recomendation/features/home/presentation/screens/home_screen.dart';
import 'package:skincare_recomendation/features/home/presentation/screens/last_recommendation_screen.dart';
import 'package:skincare_recomendation/features/navigations/presentation/screens/navigation_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRoute {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/insight',
                name: 'insight',
                builder: (context, state) => const Scaffold(
                  body: Center(child: Text('Insight Screen')),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                name: 'history',
                builder: (context, state) => const Scaffold(
                  body: Center(child: Text('Riwayat Screen')),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/myaccount',
                name: 'myaccount',
                builder: (context, state) => const Scaffold(
                  body: Center(child: Text('Akun Saya Screen')),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/last-recommendation',
        name: 'last-recommendation',
        builder: (context, state) {
          final title = state.extra as String? ?? 'Rekomendasi';
          return LastRecommendationScreen(title: title);
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
