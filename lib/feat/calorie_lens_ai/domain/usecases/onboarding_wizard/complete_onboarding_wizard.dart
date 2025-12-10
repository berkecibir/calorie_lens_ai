import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding_wizard/onboarding_wizard_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CompleteOnboardingWizard {
  Future<Either<Failure, void>> call(NoParams params);
}

class CompleteOnboardingWizardImpl implements CompleteOnboardingWizard {
  final OnboardingWizardRepository repository;

  const CompleteOnboardingWizardImpl({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.completeOnboardingWizard();
  }
}
