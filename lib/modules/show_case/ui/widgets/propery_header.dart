import 'package:flutter/material.dart';
import 'property.dart';

class PropertyHeader extends StatelessWidget {
  const PropertyHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: const [
          Property(text: "Name"),
          Property(text: "Description"),
          Property(text: "Default"),
        ],
      ),
    );
  }
}
