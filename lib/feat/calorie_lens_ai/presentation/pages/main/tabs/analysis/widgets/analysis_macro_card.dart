import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/macro_label_text.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/macro_value_text.dart';
import 'package:flutter/material.dart';

class AnalysisMacroCard extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const AnalysisMacroCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: DevicePadding.medium.all,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSizes.s12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            MacroValueText(value: value, color: color),
            const SizedBox(height: AppSizes.s4),
            MacroLabelText(label: label),
          ],
        ),
      ),
    );
  }
}
