import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> checkOnboardingStatus();
  Future<void> completeOnboarding();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  // ignore: constant_identifier_names
  static const String ONBOARDING_STATUS_KEY = 'onBoardingCompleted';

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
