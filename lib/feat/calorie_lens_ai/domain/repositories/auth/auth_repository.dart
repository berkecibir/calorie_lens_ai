import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassoword({
    required String email,
    required String password,
    String? displayName,
  });
  Future<Either<Failure, UserEntity>> signInWithEmailPassword(
      String email, String password);
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> sendEmailVerification();
  Future<Either<Failure, void>> deleteUserAccount();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, UserEntity>> updateUserInfo(UserEntity user);
}
