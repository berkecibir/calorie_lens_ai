import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CheckOnboardingStatus {
  Future<Either<Failure, bool>> call(NoParams params);
}

class CheckOnboardingStatusImpl implements CheckOnboardingStatus {
  final OnboardingRepository repository;

  CheckOnboardingStatusImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkOnboardingStatus();
  }
}
