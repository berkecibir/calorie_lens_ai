import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
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
    final theme = Theme.of(context);
    final result = state.result;

    return SingleChildScrollView(
      padding: DevicePadding.xlarge.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Fotoğraf önizleme
          ClipRRect(
            borderRadius: AppBorderRadius.circular(AppSizes.s16),
            child: Image.file(
              state.image,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          DeviceSpacing.large.height,

          // Yemek adı + güven skoru satırı
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  result.foodName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DeviceSpacing.small.width,
              Chip(
                label: Text('%${(result.confidenceScore * 100).toInt()}'),
                side: BorderSide.none,
                backgroundColor: theme.colorScheme.primaryContainer,
              ),
            ],
          ),
          Text(
            result.portionDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          DeviceSpacing.large.height,

          // Kalori kart — SummaryCard kullanıyoruz, tutarlılık için
          SummaryCard(
            title: 'Kalori',
            icon: Icons.local_fire_department_rounded,
            children: [
              Center(
                child: Text(
                  '${result.calories} kcal',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          DeviceSpacing.medium.height,

          // Makro kart — SummaryCard içinde 3 AnalysisMacroCard
          SummaryCard(
            title: 'Besin Değerleri',
            icon: Icons.pie_chart_outline_rounded,
            children: [
              Row(
                children: [
                  AnalysisMacroCard(
                      label: 'Protein',
                      value: result.proteinG,
                      color: Colors.blue),
                  DeviceSpacing.small.width,
                  AnalysisMacroCard(
                      label: 'Karb',
                      value: result.carbsG,
                      color: Colors.orange),
                  DeviceSpacing.small.width,
                  AnalysisMacroCard(
                      label: 'Yağ', value: result.fatG, color: Colors.red),
                ],
              ),
            ],
          ),
          DeviceSpacing.xxlarge.height,

          // Tracker'a ekle butonu
          WizardContinueButton(
            onPressed: () {
              // TODO: Tracker entegrasyonu Faz 2'de gelecek
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tracker yakında eklenecek!')),
              );
            },
            text: 'Bugüne Ekle',
          ),
          DeviceSpacing.medium.height,

          // Tekrar analiz
          OutlinedButton.icon(
            onPressed: context.read<FoodAnalysisCubit>().reset,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Tekrar Analiz'),
            style: OutlinedButton.styleFrom(
              padding: DevicePadding.medium.onlyVertical,
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.circular(AppSizes.s16),
              ),
            ),
          ),
          DeviceSpacing.large.height,
        ],
      ),
    );
  }
}
