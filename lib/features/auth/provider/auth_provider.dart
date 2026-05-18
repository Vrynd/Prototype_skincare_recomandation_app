import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/services/storage_service.dart';
import 'package:skincare_recomendation/core/utils/result.dart';
import 'package:skincare_recomendation/features/auth/data/auth_service.dart';
import 'package:skincare_recomendation/features/auth/models/auth_failure.dart';
import 'package:skincare_recomendation/features/auth/models/auth_state.dart';
import 'package:skincare_recomendation/features/auth/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final StorageService _storageService;

  AuthProvider(this._authService, this._storageService) {
    _initialize();
  }

  AppAuthState _authState = const AuthInitial();
  AppAuthState get authState => _authState;

  bool get isLoading => _authState is AuthLoading;

  UserModel? get userProfile {
    final state = _authState;
    if (state is AuthAuthenticated) return state.userProfile;
    return null;
  }

  void _initialize() {
    _authService.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.initialSession) {
        if (_authService.currentUser != null) {
          // Pengecekan Kustom 7 Hari Inactivity Timeout
          final lastActiveStr = _storageService.getString(StorageService.keyLastActiveSession);
          final now = DateTime.now();
          
          if (lastActiveStr != null) {
            final lastActive = DateTime.tryParse(lastActiveStr);
            if (lastActive != null) {
              final difference = now.difference(lastActive).inDays;
              if (difference >= 7) {
                // Sesi sudah mati kutu (melewati 7 hari tanpa interaksi)
                await signOut();
                return;
              }
            }
          }
          
          // Jika masih aman, update tanggal aktif terakhir ke sekarang (Rolling Expiration)
          await _storageService.setString(StorageService.keyLastActiveSession, now.toIso8601String());

          await fetchUserProfile();
        } else {
          _updateState(const AuthUnauthenticated());
        }
      } else if (event == AuthChangeEvent.signedOut) {
        _updateState(const AuthUnauthenticated());
      }
    });
  }

  Future<void> fetchUserProfile() async {
    _updateState(const AuthLoading());
    final result = await _authService.getCurrentUserProfile();

    switch (result) {
      case Success(data: final profile):
        if (profile != null) {
          _updateState(AuthAuthenticated(profile));
        } else {
          _updateState(const AuthUnauthenticated());
        }
      case Failure(error: final failure):
        _updateState(AuthError(failure));
    }
  }

  Future<AuthFailure?> signUp({
    required String email,
    required String password,
    required String namaLengkap,
  }) async {
    _updateState(const AuthLoading());
    final result = await _authService.signUp(
      email: email,
      password: password,
      namaLengkap: namaLengkap,
    );

    switch (result) {
      case Success():
        return null;
      case Failure(error: final failure):
        _updateState(AuthError(failure));
        return failure;
    }
  }

  Future<AuthFailure?> signIn({
    required String email,
    required String password,
  }) async {
    _updateState(const AuthLoading());
    final result = await _authService.signIn(email: email, password: password);

    switch (result) {
      case Success():
        return null;
      case Failure(error: final failure):
        _updateState(AuthError(failure));
        return failure;
    }
  }

  Future<void> signOut() async {
    _updateState(const AuthLoading());
    await _authService.signOut();
  }

  void _updateState(AppAuthState newState) {
    _authState = newState;
    notifyListeners();
  }
}
