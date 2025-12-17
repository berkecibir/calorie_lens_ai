import 'dart:async';
import 'dart:io';
import 'package:calorie_lens_ai_app/core/error/exceptions.dart';
import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/auth/auth_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/auth/auth_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// Exception'ları uygulama seviyesinde anlamlı Failure'lara dönüştüren yardımcı fonksiyon.
  Failure _handleException(Exception e) {
    if (e is ServerException) {
      return ServerFailure(message: e.message);
    }

    if (e is SocketException) {
      return ServerFailure(message: "İnternet bağlantınızı kontrol edin.");
    }

    if (e is TimeoutException) {
      return ServerFailure(
          message: "İstek zaman aşımına uğradı. Lütfen tekrar deneyin.");
    }

    if (e is FormatException) {
      return ServerFailure(message: "Beklenmeyen veri formatı alındı.");
    }

    // Diğer Exception'lar için temizlenmiş bir mesaj
    final raw = e.toString().replaceFirst('Exception: ', '');
    return ServerFailure(message: raw);
  }

  @override
  Future<Either<Failure, void>> deleteUserAccount() async {
    try {
      await remoteDataSource.deleteUserAccount();
      await localDataSource.clearUserSession();
      await localDataSource.clearAuthToken();
      return const Right(null);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final cachedUser = await localDataSource.getCachedUserSession();
      if (cachedUser != null) {
        return Right(cachedUser);
      }

      final remoteUser = await remoteDataSource.getCurrentUser();
      if (remoteUser != null) {
        await localDataSource.saveUserSession(remoteUser);
      }
      return Right(remoteUser);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await remoteDataSource.sendEmailVerification();
      return const Right(null);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final userModel = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await localDataSource.saveUserSession(userModel);

      return Right(userModel);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearUserSession();
      await localDataSource.clearAuthToken();
      return const Right(null);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassoword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName ?? 'Yeni Kullanıcı',
      );

      await localDataSource.saveUserSession(userModel);

      return Right(userModel);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserInfo(UserEntity user) async {
    try {
      final userModel = user as UserModel;

      final updatedUserModel = await remoteDataSource.updateUserInfo(userModel);

      await localDataSource.updateCachedUser(updatedUserModel);

      return Right(updatedUserModel);
    } on Exception catch (e) {
      return Left(_handleException(e));
    }
  }
}
