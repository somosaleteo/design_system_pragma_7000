import 'package:flutter/material.dart';

class SecondaryOptionMenu extends StatelessWidget {
  const SecondaryOptionMenu({
    required this.text, super.key,
    this.focusNode,
    this.isAutoFocus,
    this.onTap,
  });
  final String text;
  final FocusNode? focusNode;
  final bool? isAutoFocus;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      autofocus: isAutoFocus ?? false,
      focusNode: focusNode,
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
