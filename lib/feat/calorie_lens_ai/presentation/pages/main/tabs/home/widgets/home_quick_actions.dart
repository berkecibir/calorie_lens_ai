import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Erişim',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        DeviceSpacing.small.height,
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.camera_alt_rounded,
                label: 'Yemek Tara',
                color: theme.colorScheme.primary,
                onTap: () {
                  // TODO: Navigate to food scan
                },
              ),
            ),
            DeviceSpacing.small.width,
            Expanded(
              child: _QuickActionButton(
                icon: Icons.edit_rounded,
                label: 'Manuel Ekle',
                color: const Color(0xFFFFA726),
                onTap: () {
                  // TODO: Navigate to manual entry
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: AppBorderRadius.circular(AppSizes.s12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s20,
          horizontal: AppSizes.s16,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: AppBorderRadius.circular(AppSizes.s12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: AppSizes.s32),
            DeviceSpacing.small.height,
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
