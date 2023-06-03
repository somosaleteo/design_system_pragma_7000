import 'package:flutter/material.dart';

class CheckBoxItem extends StatelessWidget {
  const CheckBoxItem({super.key, this.onChanged});
  final Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 2.0,
      child: Checkbox(value: true, onChanged: onChanged),
    );
  }
}
