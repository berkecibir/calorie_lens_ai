import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_state.dart';
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

class _OnboardingPagesState extends State<OnboardingPages> {
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _onboardingPages = [
    {
      'title': OnboardingTexts.onboardingFirstPageTitle,
      'description': OnboardingTexts.onboardingFirstPageBodyMessage,
      'icon': Icons.camera_alt_rounded,
      'gradient': const [Color(0xFF66BB6A), Color(0xFF81C784)],
    },
    {
      'title': OnboardingTexts.onboardingSecondPageTitle,
      'description': OnboardingTexts.onboardingSecondPageBodyMessage,
      'icon': Icons.track_changes_rounded,
      'gradient': const [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    },
    {
      'title': OnboardingTexts.onboardingThirdPageTitle,
      'description': OnboardingTexts.onboardingThirdPageBodyMessage,
      'icon': Icons.health_and_safety_rounded,
      'gradient': const [Color(0xFF388E3C), Color(0xFF4CAF50)],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _skipOnboarding() {
    context.read<OnboardingCubit>().completeOnboardingProcess();
  }

  void _nextPage(int currentPage) {
    if (currentPage < _onboardingPages.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onboardingCubit = context.read<OnboardingCubit>();

    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            Navigation.pushReplacementNamed(root: AppTexts.signUpPageId);
          }
          // Cubit'teki sayfa değişikliği, PageView'ı kontrol etmez.
          // PageView'ın değişimi onPageChanged ile Cubit'e bildirilir.
        },
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          buildWhen: (previous, current) => current is OnboardingPageChanged,
          builder: (context, state) {
            final currentPage = state is OnboardingPageChanged
                ? state.currentPage
                : 0; // Varsayılan sayfa 0

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary.withOpacity(0.05),
                    colorScheme.surface,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Top Bar
                    OnboardingHeader(
                      colorScheme: colorScheme,
                      currentPage: currentPage,
                      onSkip: _skipOnboarding,
                    ),
                    // PageView
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _onboardingPages.length + 1,
                        onPageChanged: (index) {
                          onboardingCubit.pageChanged(index);
                        },
                        itemBuilder: (context, index) {
                          if (index == _onboardingPages.length) {
                            return const OnboardingLastPage();
                          }
                          final page = _onboardingPages[index];
                          return OnboardingWidget(
                            title: page['title'],
                            description: page['description'],
                            icon: page['icon'],
                            gradient: page['gradient'],
                          );
                        },
                      ),
                    ),
                    // Bottom Navigation
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Column(
                        children: [
                          // Page Indicators

                          OnboardingPageIndicator(
                            currentPage: currentPage,
                            totalPages: _onboardingPages.length,
                            colorScheme: colorScheme,
                          ),
                          DeviceSpacing.xlarge.height,
                          // Next/Start Button
                          if (currentPage < _onboardingPages.length)
                            OnboardingButton(
                              currentPage: currentPage,
                              totalPages: _onboardingPages.length,
                              onPressed: () => _nextPage(currentPage),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
