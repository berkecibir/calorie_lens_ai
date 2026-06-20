import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AnalysisPickerView extends StatelessWidget {
  const AnalysisPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FoodAnalysisCubit>();

    return Padding(
      padding: DevicePadding.xlarge.all,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Statik header bölümü — rebuild olmaz
                const _AnalysisPickerHeader(),
                const Spacer(),

                // Aksiyon butonları
                WizardContinueButton(
                  onPressed: () => cubit.pickAndAnalyze(ImageSource.camera),
                  text: AnalysisPageTexts.cameraButton,
                ),
                DeviceSpacing.medium.height,
                _GalleryButton(onPressed: () => cubit.pickAndAnalyze(ImageSource.gallery)),
                DeviceSpacing.large.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalysisPickerHeader extends StatelessWidget {
  const _AnalysisPickerHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        DeviceSpacing.xxlarge.height,
        Icon(
          Icons.camera_alt_rounded,
          size: AppSizes.s64,
          color: theme.colorScheme.primary,
        ),
        DeviceSpacing.large.height,
        Text(
          AnalysisPageTexts.pickerTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        DeviceSpacing.small.height,
        Text(
          AnalysisPageTexts.pickerSubtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _GalleryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _GalleryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.photo_library_rounded),
      label: const Text(AnalysisPageTexts.galleryButton),
      style: OutlinedButton.styleFrom(
        padding: DevicePadding.medium.onlyVertical,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
        ),
      ),
    );
  }
}
