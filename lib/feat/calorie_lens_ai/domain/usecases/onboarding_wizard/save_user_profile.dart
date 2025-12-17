import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding_wizard/onboarding_wizard_repository.dart';
import 'package:dartz/dartz.dart';

class SaveUserProfile {
  final OnboardingWizardRepository repository;

  SaveUserProfile({required this.repository});

  Future<Either<Failure, void>> call(UserProfileEntity profile) async {
    return await repository.saveUserProfile(profile);
  }
}
