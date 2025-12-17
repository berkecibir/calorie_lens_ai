import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_last_page.dart';
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
      'title': AppTexts.onboardingFirstPageTitle,
      'description': AppTexts.onboardingFirstPageBodyMessage,
      'icon': Icons.camera_alt_rounded,
      'gradient': const [Color(0xFF66BB6A), Color(0xFF81C784)],
    },
    {
      'title': AppTexts.onboardingSecondPageTitle,
      'description': AppTexts.onboardingSecondPageBodyMessage,
      'icon': Icons.track_changes_rounded,
      'gradient': const [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    },
    {
      'title': AppTexts.onboardingThirdPageTitle,
      'description': AppTexts.onboardingThirdPageBodyMessage,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo veya App Name
                          Text(
                            'CalorieLens AI',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),

                          // Skip Button
                          if (currentPage < _onboardingPages.length)
                            TextButton(
                              onPressed: _skipOnboarding,
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    colorScheme.onSurface.withOpacity(0.6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Atla',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          else
                            const SizedBox(width: 60),
                        ],
                      ),
                    ),

                    // PageView
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _onboardingPages.length + 1,
                        onPageChanged: (index) {
                          // ✨ setState yerine Cubit'i kullan
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _onboardingPages.length + 1,
                              (index) {
                                // ✨ Cubit'ten gelen currentPage'i kullan
                                final isActive = currentPage == index;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: isActive ? 24 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: isActive
                                        ? colorScheme.primary
                                        : colorScheme.onSurface
                                            .withOpacity(0.2),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Next/Start Button
                          if (currentPage < _onboardingPages.length)
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                // ✨ _nextPage metodunu currentPage ile çağır
                                onPressed: () => _nextPage(currentPage),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentPage == _onboardingPages.length - 1
                                          ? 'Başla'
                                          : 'Devam',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
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
