import 'package:calorie_lens_ai_app/core/error/exceptions.dart';
import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/auth/auth_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/auth/auth_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/repositories/auth/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  final tUserModel = UserModel(
    uid: '123',
    email: tEmail,
    displayName: 'Test User',
    photoUrl: null,
    isEmailVerified: true,
    createdAt: DateTime(2023, 1, 1),
  );

  group('signInWithEmailPassword', () {
    test(
      'should return UserEntity when call to remote data source is successful',
      () async {
        // Arrange
        when(mockRemoteDataSource.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        )).thenAnswer((_) async => tUserModel);
        when(mockLocalDataSource.saveUserSession(tUserModel))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.signInWithEmailPassword(tEmail, tPassword);

        // Assert
        verify(mockRemoteDataSource.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ));
        verify(mockLocalDataSource.saveUserSession(tUserModel));
        expect(result, Right(tUserModel));
      },
    );

    test(
      'should return ServerFailure when call to remote data source throws ServerException',
      () async {
        // Arrange
        when(mockRemoteDataSource.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        )).thenThrow(ServerException(message: 'Server Error'));

        // Act
        final result = await repository.signInWithEmailPassword(tEmail, tPassword);

        // Assert
        verify(mockRemoteDataSource.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, const Left(ServerFailure(message: 'Server Error')));
      },
    );
  });

  group('signUpWithEmailAndPassoword', () {
    test(
      'should return UserEntity when call to remote data source is successful',
      () async {
        // Arrange
        when(mockRemoteDataSource.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
          displayName: 'Test User',
        )).thenAnswer((_) async => tUserModel);
        when(mockLocalDataSource.saveUserSession(tUserModel))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.signUpWithEmailAndPassoword(
          email: tEmail,
          password: tPassword,
          displayName: 'Test User',
        );

        // Assert
        verify(mockRemoteDataSource.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
          displayName: 'Test User',
        ));
        verify(mockLocalDataSource.saveUserSession(tUserModel));
        expect(result, Right(tUserModel));
      },
    );
  });

  group('signOut', () {
    test(
      'should call clearUserSession and clearAuthToken when signOut is successful',
      () async {
        // Arrange
        when(mockRemoteDataSource.signOut()).thenAnswer((_) async => {});
        when(mockLocalDataSource.clearUserSession()).thenAnswer((_) async => {});
        when(mockLocalDataSource.clearAuthToken()).thenAnswer((_) async => {});

        // Act
        final result = await repository.signOut();

        // Assert
        verify(mockRemoteDataSource.signOut());
        verify(mockLocalDataSource.clearUserSession());
        verify(mockLocalDataSource.clearAuthToken());
        expect(result, const Right(null));
      },
    );
  });
}
