import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class FoodInfoRow extends StatelessWidget {
  final String foodName;
  final double confidenceScore;

  const FoodInfoRow({
    super.key,
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
