import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding/onboarding_local_data_source.dart';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  // ignore: constant_identifier_names
  static const String ONBOARDING_STATUS_KEY =
      OnboardingTexts.onboardingCompletedLocalKey;

  final SharedPreferencesHelper sharedPreferencesHelper;

  OnboardingLocalDataSourceImpl({required this.sharedPreferencesHelper});

  @override
  Future<bool> checkOnboardingStatus() async {
    return (await sharedPreferencesHelper.getBool(ONBOARDING_STATUS_KEY)) ??
        false;
  }

  @override
  Future<void> completeOnboarding() async {
    await sharedPreferencesHelper.setBool(ONBOARDING_STATUS_KEY, true);
  }
}
