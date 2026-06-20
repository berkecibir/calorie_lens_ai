import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class ErrorIcon extends StatelessWidget {
  const ErrorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error_outline_rounded,
      size: AppSizes.s64,
      color: Theme.of(context).colorScheme.error,
    );
  }
}
