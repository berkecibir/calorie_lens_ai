import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding_wizard/onboarding_wizard_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserProfile implements UseCase<UserProfileEntity, NoParams> {
  final OnboardingWizardRepository repository;

  GetUserProfile({required this.repository});
  Future<Either<Failure, UserProfileEntity>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}
