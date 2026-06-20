import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/analysis_macro_card.dart';
import 'package:flutter/material.dart';

class MacroRow extends StatelessWidget {
  final double proteinG;
  final double carbsG;
  final double fatG;

  const MacroRow({
    super.key,
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
