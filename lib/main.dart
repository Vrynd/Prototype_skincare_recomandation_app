import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:skincare_recomendation/app.dart';
import 'package:skincare_recomendation/core/services/storage_service.dart';

Future<void> main() async {
  // Pastikan binding Flutter sudah siap
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://dedqbqjsyykcfsqwpyag.supabase.co',
    anonKey: 'sb_publishable_WHQ0SDf2uTUTUnHY1ixK9g_Bbe4hbVM',
  );

  // 2. Inisialisasi SharedPreferences & Local Storage Service
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);

  // 3. Jalankan Aplikasi
  runApp(
    MyApp(storageService: storageService),
  );
}
