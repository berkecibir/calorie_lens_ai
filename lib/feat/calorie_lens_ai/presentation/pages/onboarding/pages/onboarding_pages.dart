import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/mixin/onboarding_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_last_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/widget/onboarding_button.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/widget/onboarding_header.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/widget/onboarding_page_indicator.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/widget/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPages extends StatefulWidget {
  static const String id = AppTexts.onboardingPageId;
  const OnboardingPages({super.key});

  @override
  State<OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages>
    with OnboardingMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        colorScheme.primary.withValues(alpha: 0.05),
        colorScheme.surface,
      ],
    );

    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: onOnboardingStateChanged, // Mixin'den geliyor
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          buildWhen: (previous, current) => current is OnboardingPageChanged,
          builder: (context, state) {
            final currentPage =
                state is OnboardingPageChanged ? state.currentPage : 0;

            return Container(
              decoration: BoxDecoration(gradient: backgroundGradient),
              child: SafeArea(
                child: Column(
                  children: [
                    // Top Bar
                    OnboardingHeader(
                      colorScheme: colorScheme,
                      currentPage: currentPage,
                      onSkip: skipOnboarding, // Mixin
                    ),

                    // PageView Area
                    Expanded(
                      child: PageView.builder(
                        controller: pageController, // Mixin
                        itemCount: pages.length + 1, // Mixin
                        onPageChanged: onPageChanged, // Mixin
                        itemBuilder: (context, index) {
                          if (index == pages.length) {
                            return const OnboardingLastPage();
                          }
                          final pageData = pages[index];
                          return OnboardingWidget(
                            title: pageData.title,
                            description: pageData.description,
                            icon: pageData.icon,
                            gradient: pageData.gradient,
                          );
                        },
                      ),
                    ),

                    // Bottom Navigation Area
                    _buildBottomNavigation(context,
                        currentPage: currentPage, colorScheme: colorScheme),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context, {
    required int currentPage,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        children: [
          OnboardingPageIndicator(
            currentPage: currentPage,
            totalPages: pages.length,
            colorScheme: colorScheme,
          ),
          DeviceSpacing.xlarge.height,
          if (currentPage < pages.length)
            OnboardingButton(
              currentPage: currentPage,
              totalPages: pages.length,
              onPressed: () => nextPage(currentPage), // Mixin
            ),
        ],
      ),
    );
  }
}
