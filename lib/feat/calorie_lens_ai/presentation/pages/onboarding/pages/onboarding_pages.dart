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
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingPages = [
    {
      'title': AppTexts.onboardingFirstPageTitle,
      'description': AppTexts.onboardingFirstPageBodyMessage,
      'icon': Icons.camera_alt,
    },
    {
      'title': AppTexts.onboardingSecondPageTitle,
      'description': AppTexts.onboardingSecondPageBodyMessage,
      'icon': Icons.track_changes,
    },
    {
      'title': AppTexts.onboardingThirdPageTitle,
      'description': AppTexts.onboardingThirdPageBodyMessage,
      'icon': Icons.health_and_safety,
    },
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            Navigation.pushReplacementNamed(root: AppTexts.signUpPageId);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingPages.length + 1, // +1 for last page
                itemBuilder: (context, index) {
                  if (index == _onboardingPages.length) {
                    return const OnboardingLastPage();
                  }
                  final page = _onboardingPages[index];
                  return OnboardingWidget(
                    title: page['title'],
                    description: page['description'],
                    icon: page['icon'],
                    imageUrl: '', // Add image URL if needed
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button for first pages
                  if (_currentPage < _onboardingPages.length)
                    TextButton(
                      onPressed: () {
                        context
                            .read<OnboardingCubit>()
                            .completeOnboardingProcess();
                      },
                      child: const Text('Atla'),
                    )
                  else
                    const SizedBox.shrink(),
                  Row(
                    children: List.generate(_onboardingPages.length + 1, (
                      index,
                    ) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  if (_currentPage < _onboardingPages.length)
                    IconButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(Icons.arrow_forward),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
