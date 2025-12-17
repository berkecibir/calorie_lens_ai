import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/home/home_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/activity_level_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/age_height_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/diet_allergies_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/gender_selection_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/summary_step.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/weight_goal_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingWizardPage extends StatefulWidget {
  static const String id = "onboarding_wizard_page";
  const OnboardingWizardPage({super.key});

  @override
  State<OnboardingWizardPage> createState() => _OnboardingWizardPageState();
}

class _OnboardingWizardPageState extends State<OnboardingWizardPage> {
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
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
              Navigation.pushReplacementNamed(root: HomePage.id);
            } else if (state is OnboardingWizardCompleted) {
            } else if (state is OnboardingWizardError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
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
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable swipe to enforce validaton
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

                  // Navigation Buttons (Managed by individual steps or global?)
                  // Decision: Each step might have different validation needs.
                  // However, a global "Next" button simplifies the layout if validation state is shared.
                  // For now, let's keep navigation control passed down to steps or handled globally.
                  // Better UX: Steps contain the data, maybe they should drive the "Next" validity?
                  // Or simplified: This page just holds the view, and steps call `context.read<OnboardingWizardCubit>().nextPage()`?
                  // Actually, let's pass a callback or let steps assume they are in this generic container.
                  // Simpler: Steps are just widgets. The "Next" button can be here.
                  // BUT Validation! The Page doesn't know if Step 2 inputs are valid.
                  // Solution: Let each step handle its own "Next" button, calling `_nextPage`.
                  // OR: Use a shared "FormKey" or "IsValid" state in Cubit.
                  // Approach: Each step will have its own Next button for better control/validation.
                  // OR: We pass the `onNext` callback to the steps.
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          if (_currentPage > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: _previousPage,
            )
          else
            const SizedBox(
                width:
                    48), // Spacer to keep title centered if needed, or just alignment

          Expanded(
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / 6,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
