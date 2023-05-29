import 'package:flutter/material.dart';

import '../../../blocs/bloc_drawer.dart';
import 'list_tile_drawer_widget.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({
    required this.drawerMainMenuBloc,
    super.key,
  });

  final DrawerMainMenuBloc drawerMainMenuBloc;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Image.asset(drawerMainMenuBloc.mainCover),
            ),
          ),
          ...drawerMainMenuBloc.listMenuOptions,
          const ListTileExitDrawerWidget()
        ],
      ),
    );
  }
}
