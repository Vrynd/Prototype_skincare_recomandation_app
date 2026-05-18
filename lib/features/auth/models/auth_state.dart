import 'user_model.dart';
import 'auth_failure.dart';

sealed class AppAuthState {
  const AppAuthState();
}
class AuthInitial extends AppAuthState { const AuthInitial(); }
class AuthLoading extends AppAuthState { const AuthLoading(); }
class AuthAuthenticated extends AppAuthState {
  final UserModel userProfile;
  const AuthAuthenticated(this.userProfile);
}
class AuthUnauthenticated extends AppAuthState { const AuthUnauthenticated(); }
class AuthError extends AppAuthState {
  final AuthFailure failure;
  const AuthError(this.failure);
}
