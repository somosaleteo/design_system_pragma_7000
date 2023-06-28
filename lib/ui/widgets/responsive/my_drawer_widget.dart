import 'package:flutter/material.dart';
import '../../../blocs/bloc_drawer.dart';
import '../../../modules/show_case/ui/widgets/menu_header.dart';
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
          const DrawerHeader(
            child: MenuHeader(),
          ),
          ...drawerMainMenuBloc.listMenuOptions,
          const ListTileExitDrawerWidget()
        ],
      ),
    );
  }
}
