import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/onboarding_wizard/user_profile_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingWizardLocalDataSourceImpl
    implements OnboardingWizardLocalDataSource {
  // ignore: constant_identifier_names
  static const String BOX_NAME = 'onboarding_wizard_box';
  // ignore: constant_identifier_names
  static const String USER_PROFILE_KEY = 'userProfile';

  final SharedPreferencesHelper sharedPreferencesHelper; // Keeping to match injection, though unused for main data now

  OnboardingWizardLocalDataSourceImpl({required this.sharedPreferencesHelper});

  Future<Box> _openBox() async {
    if (!Hive.isBoxOpen(BOX_NAME)) {
      return await Hive.openBox(BOX_NAME);
    }
    return Hive.box(BOX_NAME);
  }

  @override
  Future<UserProfileEntity> getUserProfile() async {
     try {
      final box = await _openBox();
      final data = box.get(USER_PROFILE_KEY);
      if (data != null) {
        // Data should be Map<dynamic, dynamic> from Hive, cast to Map<String, dynamic>
        final map = Map<String, dynamic>.from(data as Map);
        return UserProfileModel.fromJson(map).toEntity();
      }
      return UserProfileEntity.empty();
    } catch (e) {
      // Fallback or error logging
      return UserProfileEntity.empty();
    }
  }

  @override
  Future<void> saveUserProfile(UserProfileEntity profile) async {
    final model = UserProfileModel.fromEntity(profile);
    final box = await _openBox();
    await box.put(USER_PROFILE_KEY, model.toJson());
  }

  @override
  Future<void> clearTempCache() async {
     final box = await _openBox();
     await box.delete(USER_PROFILE_KEY);
  }
}
