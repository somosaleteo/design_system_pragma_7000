import 'package:flutter/material.dart';

import '../../../blocs/bloc_drawer.dart';
import '../../../blocs/navigator_bloc.dart';

class MyAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarWidget({
    required this.navigatorBloc,
    required this.drawerMainMenuBloc,
    super.key,
  });
  final NavigatorBloc navigatorBloc;
  final DrawerMainMenuBloc drawerMainMenuBloc;
  @override
  Widget build(BuildContext context) {
    Widget leadingButton = const Text('');
    if (navigatorBloc.historyPageLength > 1) {
      leadingButton = IconButton(
        icon: const Icon(
          Icons.chevron_left,
        ),
        onPressed: navigatorBloc.back,
      );
    }
    final String title = navigatorBloc.title;
    final List<Widget> listActions = <Widget>[];
    if (drawerMainMenuBloc.listMenuOptions.isNotEmpty) {
      listActions.add(
        IconButton(
          icon: const Icon(
            Icons.menu,
          ),
          onPressed: () {
            drawerMainMenuBloc.openDrawer();
          },
        ),
      );
    }
    return AppBar(
      title: Text(title),
      leading: leadingButton,
      actions: listActions,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}
