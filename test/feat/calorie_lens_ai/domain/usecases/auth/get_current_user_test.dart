import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_current_user_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late GetCurrentUser useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = GetCurrentUser(repository: mockRepository);
  });

  final tUserEntity = UserEntity(
    uid: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    photoUrl: null,
    isEmailVerified: true,
    createdAt: DateTime(2023, 1, 1),
  );

  test(
    'should return UserEntity when user is authenticated',
    () async {
      // Arrange
      when(mockRepository.getCurrentUser())
          .thenAnswer((_) async => Right(tUserEntity));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.getCurrentUser());
      expect(result, Right(tUserEntity));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return null when no user is authenticated',
    () async {
      // Arrange
      when(mockRepository.getCurrentUser())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.getCurrentUser());
      expect(result, const Right(null));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return ServerFailure when repository call fails',
    () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Failed to get user');
      when(mockRepository.getCurrentUser())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.getCurrentUser());
      expect(result, const Left(tFailure));
    },
  );
}
