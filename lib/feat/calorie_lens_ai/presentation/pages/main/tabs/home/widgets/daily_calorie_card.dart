import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/home_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/subwidgets/info_row.dart';
import 'package:flutter/material.dart';

class DailyCalorieCard extends StatelessWidget {
  final double dailyGoal;
  final int consumed;

  const DailyCalorieCard({
    super.key,
    required this.dailyGoal,
    required this.consumed,
  });

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
        borderRadius: AppBorderRadius.circular(AppSizes.s16),
      ),
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
                  'Daily Calorie',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DeviceSpacing.small.height,
                InfoRow(
                  label: HomePageTexts.consumedLabel,
                  value: '$consumed ${HomePageTexts.kcalUnit}',
                ),
                DeviceSpacing.xsmall.height,
                InfoRow(
                  label: HomePageTexts.targetLabel,
                  value: '${dailyGoal.toInt()} ${HomePageTexts.kcalUnit}',
                ),
                DeviceSpacing.xsmall.height,
                InfoRow(
                  label: HomePageTexts.remainingLabel,
                  value: '$remaining ${HomePageTexts.kcalUnit}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
