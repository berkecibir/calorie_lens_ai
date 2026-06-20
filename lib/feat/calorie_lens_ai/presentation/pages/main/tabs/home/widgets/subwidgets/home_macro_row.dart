import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/home_page_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/cards/nutrient_card.dart';
import 'package:flutter/material.dart';

class HomeMacroRow extends StatelessWidget {
  final int consumedProtein;
  final int proteinTarget;
  final int consumedCarbs;
  final int carbTarget;
  final int consumedFat;
  final int fatTarget;

  const HomeMacroRow({
    super.key,
    required this.consumedProtein,
    required this.proteinTarget,
    required this.consumedCarbs,
    required this.carbTarget,
    required this.consumedFat,
    required this.fatTarget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NutrientCard(
            label: HomePageTexts.proteinLabel,
            current: consumedProtein,
            target: proteinTarget,
            color: const Color(0xFF42A5F5),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: NutrientCard(
            label: HomePageTexts.carbLabel,
            current: consumedCarbs,
            target: carbTarget,
            color: const Color(0xFFFFA726),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: NutrientCard(
            label: HomePageTexts.fatLabel,
            current: consumedFat,
            target: fatTarget,
            color: const Color(0xFFEF5350),
          ),
        ),
      ],
    );
  }
}
