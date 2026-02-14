import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class DailyCalorieCard extends StatelessWidget {
  final double dailyGoal;
  final int consumed;
  const DailyCalorieCard(
      {super.key, required this.dailyGoal, required this.consumed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (consumed / dailyGoal).clamp(0.0, 1.0);
    final remaining = (dailyGoal - consumed).toInt();
    return Container(
      padding: DevicePadding.large.all,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppBorderRadius.circular(AppSizes.s16)),
      child: Row(
        children: [
          // Progress
          SizedBox(
            width: AppSizes.s80,
            height: AppSizes.s80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: AppSizes.s8,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Center(
                  child: Text(
                    '${(progress * 100).toInt()}%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.s20),
          // Bilgiler
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Günlük Kalori',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DeviceSpacing.small.height,
                _InfoRow(label: 'Tüketilen', value: '$consumed kcal'),
                DeviceSpacing.xsmall.height,
                _InfoRow(label: 'Hedef', value: '${dailyGoal.toInt()} kcal'),
                DeviceSpacing.xsmall.height,
                _InfoRow(label: 'Kalan', value: '$remaining kcal'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Private helper widget - Sadece bu dosyada kullanılıyor
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: AppSizes.s13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.s13,
          ),
        ),
      ],
    );
  }
}
