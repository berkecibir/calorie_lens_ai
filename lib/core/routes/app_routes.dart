import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/forgot_password/forgot_password_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_up_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/main_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_pages.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/pages/onboarding_wizard_page.dart';
import 'package:flutter/material.dart';
import '../../feat/calorie_lens_ai/presentation/pages/splash/page/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SignUpPage.id: (context) => const SignUpPage(),
    SignInPage.id: (context) => const SignInPage(),
    OnboardingPages.id: (context) => const OnboardingPages(),
    OnboardingWizardPages.id: (context) => const OnboardingWizardPages(),
    MainPage.id: (context) => const MainPage(),
    SplashPage.id: (context) => const SplashPage(),
    ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
  };
}
