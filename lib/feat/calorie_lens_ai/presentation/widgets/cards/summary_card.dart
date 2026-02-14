import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const SummaryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        side: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: DevicePadding.medium.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon,
                    size: AppSizes.s20, color: theme.colorScheme.primary),
                const SizedBox(width: AppSizes.s8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Divider(height: AppSizes.s24),
            ...children,
          ],
        ),
      ),
    );
  }
}
