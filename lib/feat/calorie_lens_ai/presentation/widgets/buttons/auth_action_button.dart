import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final IconData? icon;

  const AuthActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.icon = Icons.arrow_forward_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.s56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.circular(AppSizes.s16),
          ),
          elevation: AppSizes.s2,
        ),
        child: isLoading
            ? SizedBox(
                height: AppSizes.s20,
                width: AppSizes.s20,
                child: CircularProgressIndicator(
                  strokeWidth: AppSizes.s2,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: AppSizes.s16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (icon != null) ...[
                    DeviceSpacing.small.width,
                    Icon(icon, size: AppSizes.s20),
                  ],
                ],
              ),
      ),
    );
  }
}
