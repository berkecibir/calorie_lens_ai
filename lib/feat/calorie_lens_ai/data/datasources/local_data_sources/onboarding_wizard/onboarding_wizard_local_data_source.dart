import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';

abstract class OnboardingWizardLocalDataSource {
  Future<UserProfileEntity> getUserProfile({String? userId});
  Future<void> saveUserProfile(UserProfileEntity profile, {String? userId});
  Future<void> clearTempCache({String? userId});
  Future<bool> checkOnboardingWizardStatus({String? userId});
  Future<void> completeOnboardingWizard({String? userId});
}
