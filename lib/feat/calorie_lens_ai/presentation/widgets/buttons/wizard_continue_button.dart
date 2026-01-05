import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:flutter/material.dart';

class WizardContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  const WizardContinueButton(
      {super.key,
      required this.onPressed,
      this.text = 'Devam Et',
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
            padding: DevicePadding.medium.onlyVertical,
            shape: RoundedRectangleBorder(
              borderRadius: AppBorderRadius.circular(AppSizes.s16),
            )),
        child: isLoading
            ? SizedBox(
                height: AppSizes.s20,
                width: AppSizes.s20,
                child: CircularProgressIndicator(
                  strokeWidth: AppSizes.s2,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : Text(text));
  }
}
