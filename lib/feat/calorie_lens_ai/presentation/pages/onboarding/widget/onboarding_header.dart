import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  final int currentPage;
  final VoidCallback onSkip;

  const OnboardingHeader({
    super.key,
    required this.colorScheme,
    required this.currentPage,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo veya App Name
          Text(
            'CalorieLens AI',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
          ),

          // Skip Button
          if (currentPage < 3) // Assuming 3 main onboarding pages
            TextButton(
              onPressed: onSkip,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onSurface.withOpacity(0.6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'Atla',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            const SizedBox(width: 60),
        ],
      ),
    );
  }
}
