import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? lastLogin;

  const UserModel(
      {required this.uid,
      required this.createdAt,
      required this.email,
      this.displayName,
      this.lastLogin,
      this.photoUrl});
  @override
  List<Object?> get props =>
      [uid, email, displayName, photoUrl, createdAt, lastLogin];
}
