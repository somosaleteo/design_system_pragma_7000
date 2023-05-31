import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.width,
    this.height,
    this.radius,
    this.shadow,
    this.padding,
  });

  final String text;
  final Color? color;
  final double? width, height, radius, shadow, padding;
  final VoidCallback onPressed;
  //TODO: Verificar estados (?)

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
