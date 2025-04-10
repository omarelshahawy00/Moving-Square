import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool disabled;

  const SquareButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: Text(label),
    );
  }
}
