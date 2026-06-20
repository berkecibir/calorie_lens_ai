import 'package:flutter/material.dart';

class MacroLabelText extends StatelessWidget {
  final String label;

  const MacroLabelText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
    );
  }
}
