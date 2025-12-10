import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/onboarding_wizard/onboarding_wizard_repository.dart';

abstract class CheckOnboardingWizardStatus {
  Future<Either<Failure, bool>> call(NoParams params);
}

class CheckOnboardingWizardStatusImpl implements CheckOnboardingWizardStatus {
  final OnboardingWizardRepository repository;

  const CheckOnboardingWizardStatusImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkOnboardingWizardStatus();
  }
}
