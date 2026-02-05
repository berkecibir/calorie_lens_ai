import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_model_test.mocks.dart';

@GenerateMocks([DocumentSnapshot, User, UserMetadata])
void main() {
  final tDateTime = DateTime(2023, 1, 1, 12, 0, 0);
  final tLastLogin = DateTime(2023, 6, 1, 10, 0, 0);

  group('UserModel', () {
    group('fromJson / toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final userModel = UserModel(
          uid: '123',
          email: 'test@example.com',
          displayName: 'Test User',
          photoUrl: 'https://example.com/photo.jpg',
          createdAt: tDateTime,
          lastLogin: tLastLogin,
          isEmailVerified: true,
        );

        // Act
        final result = userModel.toJson();

        // Assert
        expect(result, {
          AppTexts.uid: '123',
          AppTexts.email: 'test@example.com',
          AppTexts.displayName: 'Test User',
          AppTexts.photoUrl: 'https://example.com/photo.jpg',
          AppTexts.createdAt: tDateTime.toIso8601String(),
          AppTexts.lastLogin: tLastLogin.toIso8601String(),
          AppTexts.isEmailVerified: true,
        });
      });

      test('should correctly deserialize from JSON', () {
        // Arrange
        final json = {
          AppTexts.uid: '123',
          AppTexts.email: 'test@example.com',
          AppTexts.displayName: 'Test User',
          AppTexts.photoUrl: 'https://example.com/photo.jpg',
          AppTexts.createdAt: tDateTime.toIso8601String(),
          AppTexts.lastLogin: tLastLogin.toIso8601String(),
          AppTexts.isEmailVerified: true,
        };

        // Act
        final result = UserModel.fromJson(json);

        // Assert
        expect(result.uid, '123');
        expect(result.email, 'test@example.com');
        expect(result.displayName, 'Test User');
        expect(result.photoUrl, 'https://example.com/photo.jpg');
        expect(result.createdAt, tDateTime);
        expect(result.lastLogin, tLastLogin);
        expect(result.isEmailVerified, true);
      });

      test('should handle null optional fields in JSON', () {
        // Arrange
        final json = {
          AppTexts.uid: '123',
          AppTexts.email: 'test@example.com',
          AppTexts.displayName: null,
          AppTexts.photoUrl: null,
          AppTexts.createdAt: tDateTime.toIso8601String(),
          AppTexts.lastLogin: null,
          AppTexts.isEmailVerified: false,
        };

        // Act
        final result = UserModel.fromJson(json);

        // Assert
        expect(result.uid, '123');
        expect(result.email, 'test@example.com');
        expect(result.displayName, null);
        expect(result.photoUrl, null);
        expect(result.lastLogin, null);
        expect(result.isEmailVerified, false);
      });

      test('should round-trip JSON serialization', () {
        // Arrange
        final userModel = UserModel(
          uid: '123',
          email: 'test@example.com',
          displayName: 'Test User',
          photoUrl: 'https://example.com/photo.jpg',
          createdAt: tDateTime,
          lastLogin: tLastLogin,
          isEmailVerified: true,
        );

        // Act
        final json = userModel.toJson();
        final result = UserModel.fromJson(json);

        // Assert
        expect(result.uid, userModel.uid);
        expect(result.email, userModel.email);
        expect(result.displayName, userModel.displayName);
        expect(result.photoUrl, userModel.photoUrl);
        expect(result.createdAt, userModel.createdAt);
        expect(result.lastLogin, userModel.lastLogin);
        expect(result.isEmailVerified, userModel.isEmailVerified);
      });
    });

    group('fromFirestore / toFirestore', () {
      test('should correctly serialize to Firestore format', () {
        // Arrange
        final userModel = UserModel(
          uid: '123',
          email: 'test@example.com',
          displayName: 'Test User',
          photoUrl: 'https://example.com/photo.jpg',
          createdAt: tDateTime,
          lastLogin: tLastLogin,
          isEmailVerified: true,
        );

        // Act
        final result = userModel.toFirestore();

        // Assert
        expect(result[AppTexts.email], 'test@example.com');
        expect(result[AppTexts.displayName], 'Test User');
        expect(result[AppTexts.photoUrl], 'https://example.com/photo.jpg');
        expect(result[AppTexts.createdAt], isA<Timestamp>());
        expect(result[AppTexts.lastLogin], isA<Timestamp>());
        expect(result[AppTexts.isEmailVerified], true);
      });

      test('should handle null lastLogin in toFirestore', () {
        // Arrange
        final userModel = UserModel(
          uid: '123',
          email: 'test@example.com',
          displayName: 'Test User',
          photoUrl: null,
          createdAt: tDateTime,
          lastLogin: null,
          isEmailVerified: false,
        );

        // Act
        final result = userModel.toFirestore();

        // Assert
        expect(result[AppTexts.lastLogin], null);
        expect(result[AppTexts.photoUrl], null);
      });

      test('should correctly deserialize from Firestore DocumentSnapshot', () {
        // Arrange
        final mockDoc = MockDocumentSnapshot<Map<String, dynamic>>();
        final data = {
          AppTexts.email: 'test@example.com',
          AppTexts.displayName: 'Test User',
          AppTexts.photoUrl: 'https://example.com/photo.jpg',
          AppTexts.createdAt: Timestamp.fromDate(tDateTime),
          AppTexts.lastLogin: Timestamp.fromDate(tLastLogin),
          AppTexts.isEmailVerified: true,
        };

        when(mockDoc.id).thenReturn('123');
        when(mockDoc.data()).thenReturn(data);

        // Act
        final result = UserModel.fromFirestore(mockDoc);

        // Assert
        expect(result.uid, '123');
        expect(result.email, 'test@example.com');
        expect(result.displayName, 'Test User');
        expect(result.photoUrl, 'https://example.com/photo.jpg');
        expect(result.isEmailVerified, true);
      });

      test('should handle null optional fields from Firestore', () {
        // Arrange
        final mockDoc = MockDocumentSnapshot<Map<String, dynamic>>();
        final data = {
          AppTexts.email: 'test@example.com',
          AppTexts.displayName: null,
          AppTexts.photoUrl: null,
          AppTexts.createdAt: Timestamp.fromDate(tDateTime),
          AppTexts.lastLogin: null,
          AppTexts.isEmailVerified: null,
        };

        when(mockDoc.id).thenReturn('123');
        when(mockDoc.data()).thenReturn(data);

        // Act
        final result = UserModel.fromFirestore(mockDoc);

        // Assert
        expect(result.displayName, null);
        expect(result.photoUrl, null);
        expect(result.lastLogin, null);
        expect(result.isEmailVerified, false); // Default value
      });
    });

    group('fromFirebaseAuth', () {
      test('should create UserModel from Firebase Auth data', () {
        // Act
        final result = UserModel.fromFirebaseAuth(
          uid: '123',
          email: 'test@example.com',
          displayName: 'Test User',
          photoUrl: 'https://example.com/photo.jpg',
          isEmailVerified: true,
        );

        // Assert
        expect(result.uid, '123');
        expect(result.email, 'test@example.com');
        expect(result.displayName, 'Test User');
        expect(result.photoUrl, 'https://example.com/photo.jpg');
        expect(result.isEmailVerified, true);
        expect(result.createdAt, isNotNull);
      });

      test('should handle optional fields in fromFirebaseAuth', () {
        // Act
        final result = UserModel.fromFirebaseAuth(
          uid: '123',
          email: 'test@example.com',
        );

        // Assert
        expect(result.uid, '123');
        expect(result.email, 'test@example.com');
        expect(result.displayName, null);
        expect(result.photoUrl, null);
        expect(result.isEmailVerified, false);
      });
    });

    group('fromFirebaseUser', () {
      test('should create UserModel from Firebase User object', () {
        // Arrange
        final mockUser = MockUser();
        final mockMetadata = MockUserMetadata();

        when(mockUser.uid).thenReturn('123');
        when(mockUser.email).thenReturn('test@example.com');
        when(mockUser.displayName).thenReturn('Test User');
        when(mockUser.photoURL).thenReturn('https://example.com/photo.jpg');
        when(mockUser.emailVerified).thenReturn(true);
        when(mockUser.metadata).thenReturn(mockMetadata);
        when(mockMetadata.creationTime).thenReturn(tDateTime);
        when(mockMetadata.lastSignInTime).thenReturn(tLastLogin);

        // Act
        final result = UserModel.fromFirebaseUser(mockUser);

        // Assert
        expect(result.uid, '123');
        expect(result.email, 'test@example.com');
        expect(result.displayName, 'Test User');
        expect(result.photoUrl, 'https://example.com/photo.jpg');
        expect(result.isEmailVerified, true);
        expect(result.createdAt, tDateTime);
        expect(result.lastLogin, tLastLogin);
      });

      test('should handle null email in fromFirebaseUser', () {
        // Arrange
        final mockUser = MockUser();
        final mockMetadata = MockUserMetadata();

        when(mockUser.uid).thenReturn('123');
        when(mockUser.email).thenReturn(null);
        when(mockUser.displayName).thenReturn(null);
        when(mockUser.photoURL).thenReturn(null);
        when(mockUser.emailVerified).thenReturn(false);
        when(mockUser.metadata).thenReturn(mockMetadata);
        when(mockMetadata.creationTime).thenReturn(tDateTime);
        when(mockMetadata.lastSignInTime).thenReturn(null);

        // Act
        final result = UserModel.fromFirebaseUser(mockUser);

        // Assert
        expect(result.email, AppTexts.empty);
        expect(result.displayName, null);
        expect(result.lastLogin, null);
      });

      test('should handle null creationTime with fallback', () {
        // Arrange
        final mockUser = MockUser();
        final mockMetadata = MockUserMetadata();

        when(mockUser.uid).thenReturn('123');
        when(mockUser.email).thenReturn('test@example.com');
        when(mockUser.displayName).thenReturn('Test User');
        when(mockUser.photoURL).thenReturn(null);
        when(mockUser.emailVerified).thenReturn(false);
        when(mockUser.metadata).thenReturn(mockMetadata);
        when(mockMetadata.creationTime).thenReturn(null);
        when(mockMetadata.lastSignInTime).thenReturn(null);

        // Act
        final result = UserModel.fromFirebaseUser(mockUser);

        // Assert
        expect(result.createdAt, isNotNull);
      });
    });
  });
}
