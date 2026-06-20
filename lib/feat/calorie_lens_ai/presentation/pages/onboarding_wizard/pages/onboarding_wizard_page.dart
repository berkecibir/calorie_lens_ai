import 'package:calorie_lens_ai_app/core/duration/app_duration.dart';
import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/core/widgets/snackbar/custom_snackbar.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/main_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/activity_level_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/age_height_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/diet_allergies_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/gender_selection_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/summary_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/weight_goal_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingWizardPages extends StatefulWidget {
  static const String id = AppTexts.onboardingWizardPageId;
  const OnboardingWizardPages({super.key});

  @override
  State<OnboardingWizardPages> createState() => _OnboardingWizardPagesState();
}

class _OnboardingWizardPagesState extends State<OnboardingWizardPages> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final cubit = context.read<OnboardingWizardCubit>();
        // ✅ Önce wizard status'ü kontrol et
        cubit.checkWizardStatus();
        // ✅ Eğer tamamlanmamışsa, profili yükle
        cubit.loadUserProfile();
      },
    );
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 5) {
      _pageController.nextPage(
        duration: AppDuration.short,
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: AppDuration.short,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<OnboardingWizardCubit>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<OnboardingWizardCubit, OnboardingWizardState>(
          listener: (context, state) {
            if (state is OnboardingWizardsSuccess) {
              Navigation.pushReplacementNamed(root: MainPage.id);
            } else if (state is OnboardingWizardCompleted) {
              CustomSnackbar.showSuccess(
                  context, 'Ana Sayfaya Yönlendiriliyorsunuz');
            } else if (state is OnboardingWizardError) {
              CustomSnackbar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  // Top Bar with Progress
                  _buildTopBar(theme),

                  // Main Content
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                        cubit.pageChanged(index);
                      },
                      children: [
                        GenderSelectionStep(onNext: _nextPage),
                        AgeHeightStep(onNext: _nextPage),
                        WeightGoalStep(onNext: _nextPage),
                        ActivityLevelStep(onNext: _nextPage),
                        DietAllergiesStep(onNext: _nextPage),
                        const SummaryStep(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopBar(ThemeData theme) {
    return Padding(
      padding: DevicePadding.medium.allSymtetric,
      child: Row(
        children: [
          if (_currentPage > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: _previousPage,
            )
          else
            const SizedBox(width: AppSizes.s48),
          Expanded(
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / 6,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              color: theme.colorScheme.primary,
              borderRadius: AppBorderRadius.circular(AppSizes.s4),
              minHeight: AppSizes.s8,
            ),
          ),
          const SizedBox(width: AppSizes.s48),
        ],
      ),
    );
  }
}
