import 'package:calorie_lens_ai_app/core/utils/const/onboarding_wizard_texts.dart';

class BodyValidator {
  /// Kilo validasyonu (30 - 300 kg aralığı)
  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return OnboardingWizardTexts.enterYourWeight;
    }
    final weight = double.tryParse(value);
    if (weight == null || weight < 30 || weight > 300) {
      return OnboardingWizardTexts.enterAValidWeight;
    }
    return null;
  }

  /// Boy validasyonu (100 - 250 cm aralığı)
  static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return OnboardingWizardTexts.enterYourHeight;
    }
    final height = double.tryParse(value);
    if (height == null || height < 100 || height > 250) {
      return OnboardingWizardTexts.enterAValidHeight;
    }
    return null;
  }

  /// Yaş validasyonu (10 - 120 yaş aralığı)
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return OnboardingWizardTexts.enterYourAge;
    }
    final age = int.tryParse(value);
    if (age == null || age < 10 || age > 120) {
      return OnboardingWizardTexts.enterAValidAge;
    }
    return null;
  }
}
