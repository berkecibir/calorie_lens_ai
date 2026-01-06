import 'package:calorie_lens_ai_app/core/duration/app_duration.dart';
import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:flutter/material.dart';
import '../../../../../core/ui/border/app_border_radius.dart';
import '../../../../../core/widgets/device_spacing/device_spacing.dart';

class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDuration.veryShort,
        decoration: BoxDecoration(
          color:
              isSelected ? theme.colorScheme.primaryContainer : theme.cardColor,
          borderRadius: AppBorderRadius.circular(AppSizes.s24),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: AppSizes.s2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: AppSizes.s12,
                offset: const Offset(AppSizes.s0, AppSizes.s4),
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: AppSizes.s8,
                offset: const Offset(AppSizes.s0, AppSizes.s2),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSizes.s64,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            DeviceSpacing.medium.height,
            Text(
              label,
              style: theme.textTheme.titleLarge?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
