import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/home_page_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/meal_log/meal_log_entity.dart';
import 'package:flutter/material.dart';

class TodayMealsList extends StatelessWidget {
  final List<MealLogEntity> meals;

  const TodayMealsList({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (meals.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            HomePageTexts.noMealsAdded,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSizes.s8),
      itemBuilder: (context, index) {
        final meal = meals[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          tileColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s12),
          ),
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(
              Icons.restaurant_rounded,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          title: Text(
            meal.foodName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${meal.calories} kcal • ${meal.dateTime.hour}:${meal.dateTime.minute.toString().padLeft(2, '0')}',
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
        );
      },
    );
  }
}
