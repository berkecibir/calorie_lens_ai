import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final IconData icon;
  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DevicePadding.large.all,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Theme.of(context).primaryColor),
          DeviceSpacing.xlarge.height,
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          DeviceSpacing.medium.height,
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
