import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/snackbar/custom_snackbar.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/calorie_display.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/food_image_preview.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/food_info_row.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/macro_row.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/portion_text.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/re_analyze_button.dart';
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
          FoodImagePreview(image: state.image),
          DeviceSpacing.large.height,
          FoodInfoRow(
            foodName: result.foodName,
            confidenceScore: result.confidenceScore,
          ),
          PortionText(portion: result.portionDescription),
          DeviceSpacing.large.height,
          SummaryCard(
            title: AnalysisPageTexts.calorieCardTitle,
            icon: Icons.local_fire_department_rounded,
            children: [
              CalorieDisplay(calories: result.calories),
            ],
          ),
          DeviceSpacing.medium.height,
          SummaryCard(
            title: AnalysisPageTexts.nutritionCardTitle,
            icon: Icons.pie_chart_outline_rounded,
            children: [
              MacroRow(
                proteinG: result.proteinG,
                carbsG: result.carbsG,
                fatG: result.fatG,
              ),
            ],
          ),
          DeviceSpacing.xxlarge.height,
          WizardContinueButton(
            onPressed: () => _onAddToLog(context),
            text: AnalysisPageTexts.addTodayButton,
          ),
          DeviceSpacing.medium.height,
          ReAnalyzeButton(onPressed: context.read<FoodAnalysisCubit>().reset),
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
