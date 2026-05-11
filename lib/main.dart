import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincare_recomendation/core/routes/app_route.dart';

import 'package:skincare_recomendation/core/services/storage_service.dart';
import 'package:skincare_recomendation/core/services/location_service.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

import 'package:skincare_recomendation/features/home/provider/location_provider.dart';
import 'package:skincare_recomendation/features/navigations/provider/bottom_bar_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        Provider<LocationService>(create: (_) => LocationService()),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(
            context.read<LocationService>(),
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRoute.router,
    );
  }
}
