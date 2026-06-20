import 'package:flutter/material.dart';

class ErrorMessageText extends StatelessWidget {
  final String message;

  const ErrorMessageText({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
    );
  }
}
