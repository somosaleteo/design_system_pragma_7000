import 'package:flutter/material.dart';

class DrawerOptionWidget extends StatelessWidget {
  const DrawerOptionWidget({
    required this.onPressed,
    required this.title,
    required this.icondata,
    this.description = '',
    this.getOutOnTap = true,
    super.key,
  });
  final VoidCallback onPressed;
  final String title, description;
  final IconData icondata;
  final bool getOutOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Theme.of(context).splashColor,
      onTap: () {
        onPressed();
        if (getOutOnTap) {
          Scaffold.of(context).openDrawer();
        }
      },
      title: Text(title),
      leading: Icon(icondata),
      subtitle: description.isNotEmpty ? Text(description) : null,
    );
  }
}
