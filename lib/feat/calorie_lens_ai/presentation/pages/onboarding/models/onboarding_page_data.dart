import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:flutter/material.dart';

class OnboardingPageData {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  OnboardingPageData(
      {required this.title,
      required this.description,
      required this.icon,
      required this.gradient});

  static final List<OnboardingPageData> items = [
    OnboardingPageData(
      title: OnboardingTexts.onboardingFirstPageTitle,
      description: OnboardingTexts.onboardingFirstPageBodyMessage,
      icon: Icons.camera_alt_rounded,
      gradient: const [Color(0xFF66BB6A), Color(0xFF81C784)],
    ),
    OnboardingPageData(
      title: OnboardingTexts.onboardingSecondPageTitle,
      description: OnboardingTexts.onboardingSecondPageBodyMessage,
      icon: Icons.track_changes_rounded,
      gradient: const [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    ),
    OnboardingPageData(
      title: OnboardingTexts.onboardingThirdPageTitle,
      description: OnboardingTexts.onboardingThirdPageBodyMessage,
      icon: Icons.health_and_safety_rounded,
      gradient: const [Color(0xFF388E3C), Color(0xFF4CAF50)],
    ),
  ];
}
