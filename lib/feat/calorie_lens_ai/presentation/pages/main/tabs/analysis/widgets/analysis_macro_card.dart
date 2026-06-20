import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
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
            _MacroValueText(value: value, color: color),
            const SizedBox(height: AppSizes.s4),
            _MacroLabelText(label: label),
          ],
        ),
      ),
    );
  }
}

class _MacroValueText extends StatelessWidget {
  final double value;
  final Color color;

  const _MacroValueText({
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value.toStringAsFixed(1)}g',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
    );
  }
}

class _MacroLabelText extends StatelessWidget {
  final String label;

  const _MacroLabelText({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
    );
  }
}
