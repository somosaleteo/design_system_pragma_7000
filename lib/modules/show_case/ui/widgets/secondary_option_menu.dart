import 'package:flutter/material.dart';

class SecondaryOptionMenu extends StatelessWidget {
  const SecondaryOptionMenu({super.key, required this.text, this.onTap});
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(text),
        ),
      ),
    );
  }
}
