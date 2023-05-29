import 'package:flutter/material.dart';

import '../../../blocs/bloc_responsive.dart';
import '../../../blocs/bloc_secondary_drawer.dart';
import 'secondary_drawer_option_widget.dart';

class SecondaryMainOptionMenuWidget extends StatelessWidget {
  const SecondaryMainOptionMenuWidget({
    required this.blocResponsive,
    required this.blocSecondaryDrawer,
    super.key,
  });

  final ResponsiveBloc blocResponsive;
  final DrawerSecondaryMenuBloc blocSecondaryDrawer;

  @override
  Widget build(BuildContext context) {
    blocSecondaryDrawer.isMovil = blocResponsive.isMovil;
    if (blocResponsive.isMovil) {
      return const SizedBox(width: 1.0);
    }
    final DrawerSecondaryMenuBloc menuBloc = blocSecondaryDrawer;
    final Size size = Size(
      (blocResponsive.size.width * 0.15).clamp(150, 300),
      blocResponsive.size.height,
    );

    return StreamBuilder<List<SecondaryDrawerOptionWidget>>(
      stream: blocSecondaryDrawer.listDrawerOptionSizeStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SecondaryDrawerOptionWidget>> snapshot,
      ) {
        if (menuBloc.listMenuOptions.isEmpty) {
          return const SizedBox(
            width: 0.0,
          );
        }
        return Container(
          width: size.width,
          height: size.height,
          color: Theme.of(context).colorScheme.tertiary,
          child: ListView(
            children: blocSecondaryDrawer.listMenuOptions,
          ),
        );
      },
    );
  }
}
