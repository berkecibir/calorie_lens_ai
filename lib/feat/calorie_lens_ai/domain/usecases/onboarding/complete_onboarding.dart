import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CompleteOnboarding {
  Future<Either<Failure, void>> call(NoParams params);
}

class CompleteOnboardingImpl implements CompleteOnboarding {
  final OnboardingRepository repository;

  CompleteOnboardingImpl({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.completeOnboarding();
  }
}
