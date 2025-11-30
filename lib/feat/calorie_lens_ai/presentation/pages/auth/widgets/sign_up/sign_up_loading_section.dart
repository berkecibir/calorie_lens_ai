import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class SignUpLoadingSection extends StatelessWidget {
  const SignUpLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        CircularProgressIndicator(
          color: colorScheme.primary,
        ),
        DeviceSpacing.medium.height,
        Text(
          'Hesabınız oluşturuluyor...',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
