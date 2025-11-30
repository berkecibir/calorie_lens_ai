import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final bool isEmailVerified;

  const UserEntity(
      {required this.uid,
      required this.createdAt,
      required this.email,
      this.isEmailVerified = false,
      this.displayName,
      this.lastLogin,
      this.photoUrl});
  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoUrl,
        createdAt,
        lastLogin,
        isEmailVerified
      ];
}
