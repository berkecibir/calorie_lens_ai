import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding/onboarding_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, bool>> checkOnboardingStatus() async {
    try {
      final status = await localDataSource.checkOnboardingStatus();
      return Right(status);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboarding() async {
    try {
      await localDataSource.completeOnboarding();
      return Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
