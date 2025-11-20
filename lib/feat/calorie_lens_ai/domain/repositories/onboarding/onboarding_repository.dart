import 'package:dartz/dartz.dart';
import 'package:calorie_lens_ai_app/core/error/failure.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, bool>> checkOnboardingStatus();
  Future<Either<Failure, void>> completeOnboarding();
}
