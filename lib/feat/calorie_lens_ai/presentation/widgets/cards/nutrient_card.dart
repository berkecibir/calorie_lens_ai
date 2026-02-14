import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class NutrientCard extends StatelessWidget {
  final String label;
  final int current;
  final int target;
  final Color color;
  const NutrientCard(
      {super.key,
      required this.label,
      required this.current,
      required this.target,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (current / target).clamp(0.0, 1.0);
    return Container(
      padding: DevicePadding.small.all,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppBorderRadius.circular(AppSizes.s12),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        ), // border shape klasöründen gelebilir mi ? Çöz !
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          DeviceSpacing.small.height,
          SizedBox(
              width: AppSizes.s40,
              height: AppSizes.s40,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: AppSizes.s4,
                backgroundColor: color.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              )),
          DeviceSpacing.small.height,
          Text(
            '${current}g',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '/ ${target}g',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
