import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.iconData,
    required this.title,
    required this.width,
    required this.height,
    required this.type,
    required this.onPressed,
  });
  final IconData? iconData;
  final String title;
  final double width;
  final double height;
  final String type;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: type == 'primary' ? Colors.purple : Colors.amber,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(iconData !=null)
              Icon(iconData),
            Text(title),
          ],
        ),
      ),
    );
  }
}
