import 'package:flutter/material.dart';
import '../../../blocs/bloc_drawer.dart';
import '../../../blocs/bloc_responsive.dart';
import '../../../modules/show_case/ui/widgets/menu_header.dart';
import 'drawer_option_widget.dart';

class MainOptionMenuWidget extends StatelessWidget {
  const MainOptionMenuWidget({
    required this.responsiveBloc,
    required this.drawerMainMenuBloc,
    super.key,
  });
  final ResponsiveBloc responsiveBloc;
  final DrawerMainMenuBloc drawerMainMenuBloc;

  @override
  Widget build(BuildContext context) {
    if (responsiveBloc.isMovil || responsiveBloc.isTablet) {
      return const SizedBox.shrink();
    }

    final DrawerMainMenuBloc menuBloc = drawerMainMenuBloc;
    final Size size = Size(
      (responsiveBloc.size.width * 0.15).clamp(305, 350),
      responsiveBloc.size.height,
    );

    return StreamBuilder<List<DrawerOptionWidget>>(
      stream: menuBloc.listDrawerOptionSizeStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<DrawerOptionWidget>> snapshot,
      ) {
        if (menuBloc.listMenuOptions.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          width: size.width,
          height: size.height,
          color: Theme.of(context).splashColor,
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                child: MenuHeader(),
              ),
              ...drawerMainMenuBloc.listMenuOptions.map((DrawerOptionWidget e) {
                return DrawerOptionWidget(
                  onPressed: e.onPressed,
                  title: e.title,
                  secondaryOption: e.secondaryOption,
                  icondata: e.icondata,
                  getOutOnTap: false,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
