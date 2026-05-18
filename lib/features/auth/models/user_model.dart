class UserModel {
  final String idUser;
  final String? namaLengkap;
  final String? email;
  final String? fotoProfile;
  final String? role;
  final bool? statusAkun;

  UserModel({
    required this.idUser,
    this.namaLengkap,
    this.email,
    this.fotoProfile,
    this.role,
    this.statusAkun,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['id_user'] as String,
      namaLengkap: json['nama_lengkap'] as String?,
      email: json['email'] as String?,
      fotoProfile: json['foto_profile'] as String?,
      role: json['role'] as String?,
      statusAkun: json['status_akun'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'nama_lengkap': namaLengkap,
      'email': email,
      'foto_profile': fotoProfile,
      'role': role,
      'status_akun': statusAkun,
    };
  }
}
