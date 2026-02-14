import 'package:calorie_lens_ai_app/core/duration/app_duration.dart';
import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;
  const SelectableCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconData,
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
        padding: DevicePadding.medium.all,
        decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer
                : theme.cardColor,
            borderRadius: AppBorderRadius.circular(AppSizes.s16),
            border: Border.all(
              color:
                  isSelected ? theme.colorScheme.primary : Colors.transparent,
              width: AppSizes.s1 + 0.5,
            ),
            boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: AppSizes.s4,
                  offset: const Offset(AppSizes.s0, AppSizes.s2),
                )
            ]),
        child: Row(
          children: [
            _IconContainer(
              iconData: iconData,
              isSelected: isSelected,
            ),
            SizedBox(width: AppSizes.s16),
            Expanded(
              child: _ContentColumn(
                title: title,
                description: description,
                isSelected: isSelected,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}

class _IconContainer extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  const _IconContainer({
    required this.iconData,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppSizes.s12),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.2)
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _ContentColumn extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  const _ContentColumn({
    required this.title,
    required this.description,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: AppSizes.s4),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8)
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
