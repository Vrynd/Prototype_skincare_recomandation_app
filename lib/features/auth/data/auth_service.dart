import 'package:skincare_recomendation/core/utils/result.dart';
import 'package:skincare_recomendation/features/auth/models/auth_failure.dart';
import 'package:skincare_recomendation/features/auth/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;
  User? get currentUser => _client.auth.currentUser;

  Future<Result<AuthResponse, AuthFailure>> signUp({
    required String email,
    required String password,
    required String namaLengkap,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': namaLengkap},
      );
      return Success(response);
    } on AuthException catch (e) {
      return Failure(_mapSupabaseError(e));
    } catch (e) {
      return Failure(AuthUnknownFailure(e.toString()));
    }
  }

  Future<Result<AuthResponse, AuthFailure>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Success(response);
    } on AuthException catch (e) {
      return Failure(_mapSupabaseError(e));
    } catch (e) {
      return Failure(AuthUnknownFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<Result<UserModel?, AuthFailure>> getCurrentUserProfile() async {
    final user = currentUser;
    if (user == null) return const Success(null);

    try {
      final data = await _client
          .from('users')
          .select()
          .eq('id_user', user.id)
          .maybeSingle();

      if (data != null) {
        return Success(UserModel.fromJson(data));
      }
      return const Success(null);
    } on PostgrestException catch (e) {
      return Failure(AuthUnknownFailure(e.message));
    } catch (e) {
      return Failure(AuthUnknownFailure(e.toString()));
    }
  }

  AuthFailure _mapSupabaseError(AuthException e) {
    final message = e.message.toLowerCase();
    if (message.contains('invalid login credentials')) {
      return const AuthInvalidCredentialsFailure();
    } else if (message.contains('already registered')) {
      return const AuthUserAlreadyExistsFailure();
    } else if (message.contains('network') || message.contains('connection')) {
      return const AuthNetworkFailure();
    }
    return AuthUnknownFailure(e.message);
  }
}
