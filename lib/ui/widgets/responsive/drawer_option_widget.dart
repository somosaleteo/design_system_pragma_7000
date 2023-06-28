import 'package:flutter/material.dart';

class DrawerOptionWidget extends StatelessWidget {
  const DrawerOptionWidget({
    required this.onPressed,
    required this.title,
    required this.secondaryOption,
    this.icondata,
    this.isExpanded,
    this.description = '',
    this.getOutOnTap = true,
    super.key,
  });
  final VoidCallback onPressed;
  final String title, description;
  final Widget secondaryOption;
  final IconData? icondata;
  final bool? isExpanded;
  final bool getOutOnTap;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Text(title),
      ),
      shape: const Border(),
      childrenPadding: const EdgeInsets.only(left: 25.0),
      initiallyExpanded: isExpanded ?? false,
      children: <Widget>[secondaryOption],
    );

    /*ListTile(
      iconColor: Theme.of(context).splashColor,
      onTap: () {
        onPressed();
        if (getOutOnTap) {
          Scaffold.of(context).openDrawer();
        }
      },
      title: Text(title),
      //leading: Icon(icondata),
      subtitle: description.isNotEmpty ? Text(description) : null,
    ); */
  }
}
