import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';

class OnboardingLastPage extends StatelessWidget {
  const OnboardingLastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DevicePadding.xlarge.all,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            size: AppSizes.s100,
            color: Colors.green,
          ),
          DeviceSpacing.xlarge.height,
          Text(
            'Hazırsınız!',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          DeviceSpacing.medium.height,
          Text(
            AppTexts.onboardingLastPageBodyMessage,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.s48),
          ElevatedButton(
            onPressed: () {
              context.read<OnboardingCubit>().completeOnboardingProcess();
              Navigation.pushReplacementNamed(root: AppTexts.signUpPageId);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(AppTexts.onboardingLastPageButtonTitle),
          ),
        ],
      ),
    );
  }
}
