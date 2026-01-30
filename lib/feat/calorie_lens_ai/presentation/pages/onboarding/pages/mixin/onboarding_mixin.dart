import 'package:calorie_lens_ai_app/core/duration/app_duration.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/models/onboarding_page_data.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin OnboardingMixin on State<OnboardingPages> {
  final PageController pageController = PageController();
  final List<OnboardingPageData> pages = OnboardingPageData.items;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void skipOnboarding() {
    context.read<OnboardingCubit>().completeOnboardingProcess();
  }

  void nextPage(int currentPage) {
    if (currentPage < pages.length) {
      pageController.nextPage(
        duration: AppDuration.medium,
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int index) {
    context.read<OnboardingCubit>().pageChanged(index);
  }

  void onOnboardingStateChanged(BuildContext context, OnboardingState state) {
    if (state is OnboardingCompleted) {
      Navigation.pushReplacementNamed(root: AppTexts.signUpPageId);
    }
  }
}
