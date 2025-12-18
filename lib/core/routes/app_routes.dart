import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_up_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/home/home_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_pages.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/pages/onboarding_wizard_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SignUpPage.id: (context) => const SignUpPage(),
    SignInPage.id: (context) => const SignInPage(),
    OnboardingPages.id: (context) => const OnboardingPages(),
    OnboardingWizardPages.id: (context) => const OnboardingWizardPages(),
    HomePage.id: (context) => const HomePage(),
  };
}
