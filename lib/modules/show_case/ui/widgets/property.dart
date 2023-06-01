import 'package:flutter/material.dart';

class Property extends StatelessWidget {
  const Property({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
