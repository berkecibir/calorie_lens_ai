import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/onboarding_wizard/user_profile_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../../core/utils/const/app_texts.dart';

class OnboardingWizardLocalDataSourceImpl
    implements OnboardingWizardLocalDataSource {
  // ignore: constant_identifier_names
  static const String BOX_NAME = AppTexts.onboardingWizarBoxName;
  // ignore: constant_identifier_names
  static const String USER_PROFILE_KEY =
      AppTexts.onboardingWizardUserProfileKey;
  // ignore: constant_identifier_names
  static const String WIZARD_COMPLETED_KEY =
      AppTexts.onboardingWizardCompletedKey;

  final SharedPreferencesHelper
      sharedPreferencesHelper; // Keeping to match injection, though unused for main data now

  OnboardingWizardLocalDataSourceImpl({required this.sharedPreferencesHelper});

  Future<Box> _openBox() async {
    if (!Hive.isBoxOpen(BOX_NAME)) {
      return await Hive.openBox(BOX_NAME);
    }
    return Hive.box(BOX_NAME);
  }

  @override
  Future<UserProfileEntity> getUserProfile({String? userId}) async {
    try {
      final box = await _openBox();
      final key =
          userId != null ? '${USER_PROFILE_KEY}_$userId' : USER_PROFILE_KEY;
      final data = box.get(key);
      if (data != null) {
        final map = Map<String, dynamic>.from(data as Map);
        return UserProfileModel.fromJson(map).toEntity();
      }
      return UserProfileEntity.empty();
    } catch (e) {
      return UserProfileEntity.empty();
    }
  }

  @override
  Future<void> saveUserProfile(UserProfileEntity profile,
      {String? userId}) async {
    final model = UserProfileModel.fromEntity(profile);
    final box = await _openBox();
    final key =
        userId != null ? '${USER_PROFILE_KEY}_$userId' : USER_PROFILE_KEY;
    await box.put(key, model.toJson());
  }

  @override
  Future<void> clearTempCache({String? userId}) async {
    final box = await _openBox();
    final key =
        userId != null ? '${USER_PROFILE_KEY}_$userId' : USER_PROFILE_KEY;
    await box.delete(key);
  }

  @override
  Future<bool> checkOnboardingWizardStatus({String? userId}) async {
    try {
      final box = await _openBox();
      final key = userId != null
          ? '${WIZARD_COMPLETED_KEY}_$userId'
          : WIZARD_COMPLETED_KEY;
      return box.get(key) ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> completeOnboardingWizard({String? userId}) async {
    final box = await _openBox();
    final key = userId != null
        ? '${WIZARD_COMPLETED_KEY}_$userId'
        : WIZARD_COMPLETED_KEY;
    await box.put(key, true);
  }
}
