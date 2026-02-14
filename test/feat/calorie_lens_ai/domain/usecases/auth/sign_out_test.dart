import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_out_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignOut useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignOut(repository: mockRepository);
  });

  test(
    'should call repository.signOut successfully',
    () async {
      // Arrange
      when(mockRepository.signOut()).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.signOut());
      expect(result, const Right(null));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return ServerFailure when repository call fails',
    () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Sign out failed');
      when(mockRepository.signOut())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.signOut());
      expect(result, const Left(tFailure));
    },
  );
}
