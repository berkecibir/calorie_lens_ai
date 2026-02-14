import 'package:calorie_lens_ai_app/core/duration/app_duration.dart';
import 'package:flutter/material.dart';
import '../../ui/border/app_border_radius.dart';
import '../../sizes/app_sizes.dart';

class CustomSnackbar {
  // snackbar for success message
  static void showSuccess(BuildContext context, String message,
      {Duration duration = AppDuration.threeSecond}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s8),
        ),
        duration: duration,
      ),
    );
  }

  // snackbar for error message
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = AppDuration.threeSecond,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s8),
        ),
        duration: duration,
      ),
    );
  }

  // snackbar for warning message
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = AppDuration.threeSecond,
  }) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: theme.brightness == Brightness.light
            ? const Color(0xFFFFC107) // light theme warning color
            : const Color(0xFFFFD54F), // dark theme warning color
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s8),
        ),
        duration: duration,
      ),
    );
  }

  // snackbar for info message
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = AppDuration.threeSecond,
  }) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: theme.brightness == Brightness.light
            ? const Color(0xFF2196F3) // light theme info color
            : const Color(0xFF64B5F6), // dark theme info color
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s8),
        ),
        duration: duration,
      ),
    );
  }

  // snackbar for custom message
  static void showCustom(
    BuildContext context,
    String message,
    Color backgroundColor, {
    Duration duration = AppDuration.threeSecond,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s8),
        ),
        duration: duration,
      ),
    );
  }
}
