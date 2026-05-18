sealed class AuthFailure {
  final String message;
  const AuthFailure(this.message);
}

class AuthNetworkFailure extends AuthFailure {
  const AuthNetworkFailure() : super('Terjadi kesalahan jaringan. Silakan periksa koneksi internet Anda.');
}

class AuthInvalidCredentialsFailure extends AuthFailure {
  const AuthInvalidCredentialsFailure() : super('Email atau kata sandi yang Anda masukkan salah.');
}

class AuthUserAlreadyExistsFailure extends AuthFailure {
  const AuthUserAlreadyExistsFailure() : super('Email sudah terdaftar. Silakan gunakan email lain atau masuk.');
}

class AuthUnknownFailure extends AuthFailure {
  const AuthUnknownFailure(super.message);
}
