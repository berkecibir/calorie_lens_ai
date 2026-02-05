import 'dart:convert';

import 'package:calorie_lens_ai_app/core/error/exceptions.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/auth/auth_local_data_source_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferencesHelper])
void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockSharedPreferencesHelper mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferencesHelper();
    dataSource = AuthLocalDataSourceImpl(mockSharedPreferences);
  });

  final tUserModel = UserModel(
    uid: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    photoUrl: 'https://example.com/photo.jpg',
    createdAt: DateTime(2023, 1, 1),
    lastLogin: DateTime(2023, 6, 1),
    isEmailVerified: true,
  );

  group('saveUserSession', () {
    test('should save user session to SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.saveUserSession(tUserModel);

      // Assert
      final expectedJson = jsonEncode(tUserModel.toJson());
      verify(mockSharedPreferences.setString(
        AppTexts.authUserSession,
        expectedJson,
      ));
    });

    test('should throw CacheException when saving fails', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenThrow(Exception('Failed'));

      // Act
      final call = dataSource.saveUserSession;

      // Assert
      expect(
        () => call(tUserModel),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('getCachedUserSession', () {
    test('should return UserModel when session exists', () async {
      // Arrange
      final userJson = jsonEncode(tUserModel.toJson());
      when(mockSharedPreferences.getString(any))
          .thenAnswer((_) async => userJson);

      // Act
      final result = await dataSource.getCachedUserSession();

      // Assert
      verify(mockSharedPreferences.getString(AppTexts.authUserSession));
      expect(result, isA<UserModel>());
      expect(result?.uid, tUserModel.uid);
      expect(result?.email, tUserModel.email);
    });

    test('should return null when session does not exist', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenAnswer((_) async => null);

      // Act
      final result = await dataSource.getCachedUserSession();

      // Assert
      verify(mockSharedPreferences.getString(AppTexts.authUserSession));
      expect(result, null);
    });

    test('should throw CacheException when reading fails', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenThrow(Exception('Failed'));

      // Act
      final call = dataSource.getCachedUserSession;

      // Assert
      expect(
        () => call(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('clearUserSession', () {
    test('should clear user session from SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      // Act
      await dataSource.clearUserSession();

      // Assert
      verify(mockSharedPreferences.remove(AppTexts.authUserSession));
    });

    test('should throw CacheException when clearing fails', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenThrow(Exception('Failed'));

      // Act
      final call = dataSource.clearUserSession;

      // Assert
      expect(
        () => call(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('isUserSessionExists', () {
    test('should return true when session exists and is not empty', () async {
      // Arrange
      when(mockSharedPreferences.getString(any))
          .thenAnswer((_) async => '{"uid":"123"}');

      // Act
      final result = await dataSource.isUserSessionExists();

      // Assert
      expect(result, true);
    });

    test('should return false when session is null', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenAnswer((_) async => null);

      // Act
      final result = await dataSource.isUserSessionExists();

      // Assert
      expect(result, false);
    });

    test('should return false when session is empty', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenAnswer((_) async => '');

      // Act
      final result = await dataSource.isUserSessionExists();

      // Assert
      expect(result, false);
    });

    test('should return false when exception occurs', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenThrow(Exception('Failed'));

      // Act
      final result = await dataSource.isUserSessionExists();

      // Assert
      expect(result, false);
    });
  });

  group('updateCachedUser', () {
    test('should update user session by calling saveUserSession', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.updateCachedUser(tUserModel);

      // Assert
      final expectedJson = jsonEncode(tUserModel.toJson());
      verify(mockSharedPreferences.setString(
        AppTexts.authUserSession,
        expectedJson,
      ));
    });

    test('should throw CacheException when update fails', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenThrow(Exception('Failed'));

      // Act
      final call = dataSource.updateCachedUser;

      // Assert
      expect(
        () => call(tUserModel),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('saveAuthToken', () {
    const tToken = 'test_auth_token_123';

    test('should save auth token to SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.saveAuthToken(tToken);

      // Assert
      verify(mockSharedPreferences.setString(
        AppTexts.authToken,
        tToken,
      ));
    });

    test('should throw CacheException when saving token fails', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenThrow(Exception('Failed'));

      // Act
      final call = dataSource.saveAuthToken;

      // Assert
      expect(
        () => call(tToken),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('getAuthToken', () {
    const tToken = 'test_auth_token_123';

    test('should return auth token when it exists', () async {
      // Arrange
      when(mockSharedPreferences.getString(any))
          .thenAnswer((_) async => tToken);

      // Act
      final result = await dataSource.getAuthToken();

      // Assert
      verify(mockSharedPreferences.getString(AppTexts.authToken));
      expect(result, tToken);
    });

    test('should return null when token does not exist', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenAnswer((_) async => null);

      // Act
      final result = await dataSource.getAuthToken();

      // Assert
      expect(result, null);
    });

    test('should throw CacheException when reading token fails', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenThrow(Exception('Failed'));

      // Act
      final call = dataSource.getAuthToken;

      // Assert
      expect(
        () => call(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('clearAuthToken', () {
    test('should clear auth token from SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      // Act
      await dataSource.clearAuthToken();

      // Assert
      verify(mockSharedPreferences.remove(AppTexts.authToken));
    });

    test('should throw CacheException when clearing token fails', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenThrow(Exception('Failed'));

      // Act
      final call = dataSource.clearAuthToken;

      // Assert
      expect(
        () => call(),
        throwsA(isA<CacheException>()),
      );
    });
  });
}
