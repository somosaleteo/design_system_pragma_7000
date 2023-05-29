import 'package:flutter/material.dart';

import '../../../blocs/bloc_secondary_drawer.dart';

class SecondaryDrawerOptionWidget extends StatelessWidget {
  const SecondaryDrawerOptionWidget({
    required this.onPressed,
    required this.icondata,
    required this.secondaryMenuBloc,
    this.toolTip = '',
    super.key,
    this.marginBotton = 8.0,
  });

  final VoidCallback onPressed;
  final IconData icondata;
  final String toolTip;
  final double marginBotton;

  final DrawerSecondaryMenuBloc secondaryMenuBloc;

  @override
  Widget build(BuildContext context) {
    if (secondaryMenuBloc.isMovil) {
      return Container(
        margin: EdgeInsets.only(bottom: marginBotton),
        child: FloatingActionButton(
          onPressed: onPressed,
          tooltip: toolTip,
          heroTag: UniqueKey(),
          child: Icon(icondata),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.background),
      ),
      child: ListTile(
        style: ListTileStyle.drawer,
        leading: Icon(icondata),
        title: Text(toolTip),
        onTap: onPressed,
      ),
    );
  }
}
