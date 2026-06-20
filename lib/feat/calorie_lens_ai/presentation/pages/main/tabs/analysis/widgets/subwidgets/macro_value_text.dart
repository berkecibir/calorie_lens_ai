import 'package:flutter/material.dart';

class MacroValueText extends StatelessWidget {
  final double value;
  final Color color;

  const MacroValueText({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value.toStringAsFixed(1)}g',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
    );
  }
}
