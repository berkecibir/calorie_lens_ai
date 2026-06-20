import 'package:flutter/material.dart';

class CalorieDisplay extends StatelessWidget {
  final int calories;

  const CalorieDisplay({super.key, required this.calories});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        '$calories kcal',
        style: theme.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
