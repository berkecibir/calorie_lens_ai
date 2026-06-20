import 'package:calorie_lens_ai_app/core/utils/const/home_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/subwidgets/quick_action_button.dart';
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
          HomePageTexts.quickAccessTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        DeviceSpacing.small.height,
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: Icons.camera_alt_rounded,
                label: HomePageTexts.scanFoodLabel,
                color: theme.colorScheme.primary,
                onTap: () {
                  // TODO: Navigate to food scan
                },
              ),
            ),
            DeviceSpacing.small.width,
            Expanded(
              child: QuickActionButton(
                icon: Icons.edit_rounded,
                label: HomePageTexts.manualAddLabel,
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
