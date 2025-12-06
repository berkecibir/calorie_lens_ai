import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';

abstract class OnboardingWizardLocalDataSource {
  Future<UserProfileEntity> getUserProfile();
  Future<void> saveUserProfile(UserProfileEntity profile);
  Future<void> clearTempCache();
}
