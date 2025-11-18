import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
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
      'title': 'Yemeklerinizi Tanıyın',
      'description':
          'Fotoğrafla yemeklerinizi tanımlayın ve otomatik kalori hesaplamasından yararlanın.',
      'icon': Icons.camera_alt,
    },
    {
      'title': 'Beslenmenizi Takip Edin',
      'description':
          'Günlük beslenme alışkanlıklarınızı analiz edin ve hedeflerinize ulaşın.',
      'icon': Icons.track_changes,
    },
    {
      'title': 'Sağlıklı Yaşamın Kilidine Ulaşın',
      'description':
          'Kişiye özel önerilerle sağlıklı yaşam hedeflerinize ulaşın.',
      'icon': Icons.health_and_safety,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            // Navigation to Auth (Sign Up)
            //Navigation.pushReplacementNamed(root: auth screens );
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
                        // Skip onboarding
                        context
                            .read<OnboardingCubit>()
                            .completeOnboardingProcess();
                      },
                      child: const Text('Atla'),
                    )
                  else
                    const SizedBox.shrink(),

                  // Page indicators
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

                  // Next button or empty space
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
