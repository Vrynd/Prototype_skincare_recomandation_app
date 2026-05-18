import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/routes/app_route.dart';
import 'package:skincare_recomendation/core/services/location_service.dart';
import 'package:skincare_recomendation/core/services/storage_service.dart';
import 'package:skincare_recomendation/core/services/supabase_service.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/features/home/provider/location_provider.dart';
import 'package:skincare_recomendation/features/auth/provider/password_visibility_provider.dart';
import 'package:skincare_recomendation/features/auth/provider/remember_me_provider.dart';
import 'package:skincare_recomendation/features/auth/provider/register_provider.dart';
import 'package:skincare_recomendation/features/navigations/provider/bottom_bar_provider.dart';

import 'package:skincare_recomendation/features/auth/data/auth_service.dart';
import 'package:skincare_recomendation/features/auth/provider/auth_provider.dart';

class MyApp extends StatelessWidget {
  final StorageService storageService;

  const MyApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SupabaseService>(create: (_) => SupabaseService()),
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<StorageService>.value(value: storageService),
        Provider<LocationService>(create: (_) => LocationService()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            context.read<AuthService>(),
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(
            context.read<LocationService>(),
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
        ChangeNotifierProvider(
          create: (context) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(create: (context) => RememberMeProvider()),
        ChangeNotifierProvider(
          create: (context) => PasswordIndicatorProvider(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Skincare Recommendation',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRoute.router,
      ),
    );
  }
}
