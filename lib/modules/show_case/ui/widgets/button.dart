import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.iconData,
    this.title,
    this.width,
    this.height,
    this.radius,
    this.type,
    this.onPressed,
  });
  final IconData? iconData;
  final String? title;
  final double? width;
  final double? height;
  final double? radius;
  final String? type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: type == 'primary' ? Colors.purple : Colors.amber,
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        width: width ?? 100,
        height: height ?? 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (iconData != null) Icon(iconData),
            Text(
              title ?? 'Button',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
