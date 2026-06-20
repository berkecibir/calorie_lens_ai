import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/snackbar/custom_snackbar.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/analysis_macro_card.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/cards/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalysisResultView extends StatelessWidget {
  final FoodAnalysisSuccess state;

  const AnalysisResultView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final result = state.result;

    return SingleChildScrollView(
      padding: DevicePadding.xlarge.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Statik bölüm — fotoğraf değişmez
          _FoodImagePreview(image: state.image),
          DeviceSpacing.large.height,

          // Statik bölüm — isim + güven skoru
          _FoodInfoRow(
            foodName: result.foodName,
            confidenceScore: result.confidenceScore,
          ),
          _PortionText(portion: result.portionDescription),
          DeviceSpacing.large.height,

          // Kalori kartı
          SummaryCard(
            title: AnalysisPageTexts.calorieCardTitle,
            icon: Icons.local_fire_department_rounded,
            children: [
              _CalorieDisplay(calories: result.calories),
            ],
          ),
          DeviceSpacing.medium.height,

          // Makro besin kartı
          SummaryCard(
            title: AnalysisPageTexts.nutritionCardTitle,
            icon: Icons.pie_chart_outline_rounded,
            children: [
              _MacroRow(
                proteinG: result.proteinG,
                carbsG: result.carbsG,
                fatG: result.fatG,
              ),
            ],
          ),
          DeviceSpacing.xxlarge.height,

          // Aksiyon butonları
          WizardContinueButton(
            onPressed: () => _onAddToLog(context),
            text: AnalysisPageTexts.addTodayButton,
          ),
          DeviceSpacing.medium.height,
          _ReAnalyzeButton(onPressed: context.read<FoodAnalysisCubit>().reset),
          DeviceSpacing.large.height,
        ],
      ),
    );
  }

  Future<void> _onAddToLog(BuildContext context) async {
    await context.read<FoodAnalysisCubit>().saveResultToLog(state.result);

    if (context.mounted) {
      context.read<MainCubit>().loadMainScreenData();
      CustomSnackbar.showSuccess(context, AnalysisPageTexts.savedToLogMessage);
    }
  }
}

// ── Private sub-widgets ──────────────────────────────────────────────────────

class _FoodImagePreview extends StatelessWidget {
  final dynamic image; // File

  const _FoodImagePreview({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.circular(AppSizes.s16),
      child: Image.file(
        image,
        height: 220,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _FoodInfoRow extends StatelessWidget {
  final String foodName;
  final double confidenceScore;

  const _FoodInfoRow({
    required this.foodName,
    required this.confidenceScore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            foodName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DeviceSpacing.small.width,
        Chip(
          label: Text('%${(confidenceScore * 100).toInt()}'),
          side: BorderSide.none,
          backgroundColor: theme.colorScheme.primaryContainer,
        ),
      ],
    );
  }
}

class _PortionText extends StatelessWidget {
  final String portion;

  const _PortionText({required this.portion});

  @override
  Widget build(BuildContext context) {
    return Text(
      portion,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
    );
  }
}

class _CalorieDisplay extends StatelessWidget {
  final int calories;

  const _CalorieDisplay({required this.calories});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        '$calories kcal',
        style: theme.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  final double proteinG;
  final double carbsG;
  final double fatG;

  const _MacroRow({
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnalysisMacroCard(
          label: AnalysisPageTexts.proteinLabel,
          value: proteinG,
          color: Colors.blue,
        ),
        DeviceSpacing.small.width,
        AnalysisMacroCard(
          label: AnalysisPageTexts.carbLabel,
          value: carbsG,
          color: Colors.orange,
        ),
        DeviceSpacing.small.width,
        AnalysisMacroCard(
          label: AnalysisPageTexts.fatLabel,
          value: fatG,
          color: Colors.red,
        ),
      ],
    );
  }
}

class _ReAnalyzeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ReAnalyzeButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh_rounded),
      label: const Text(AnalysisPageTexts.reAnalyzeButton),
      style: OutlinedButton.styleFrom(
        padding: DevicePadding.medium.onlyVertical,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s16),
        ),
      ),
    );
  }
}
