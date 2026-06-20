import 'package:flutter/material.dart';

class PortionText extends StatelessWidget {
  final String portion;

  const PortionText({super.key, required this.portion});

  @override
  Widget build(BuildContext context) {
    return Text(
      portion,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
    );
  }
}
