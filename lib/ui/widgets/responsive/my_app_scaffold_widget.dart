import 'package:flutter/material.dart';

import '../../../app_config.dart';
import '../../../blocs/bloc_drawer.dart';
import '../../../blocs/bloc_processing.dart';
import '../../../blocs/bloc_responsive.dart';
import '../../../blocs/bloc_secondary_drawer.dart';
import '../../../blocs/navigator_bloc.dart';
import '../../../entities/entity_bloc.dart';
import '../../pages/loading_page.dart';
import 'main_option_menu_widget.dart';
import 'my_app_bar_widget.dart';
import 'my_drawer_widget.dart';
import 'my_floating_action_button_widget.dart';
import 'secondary_main_option_menu_widget.dart';
import 'work_area_widget.dart';

/// Widgets del bloc
/// la dependencia de este Widget esta justificada desde el punto de vista de
/// rapido desarrollo. Se tiene conciencia que su testeo es extremadamente
/// difícil pero los cambios a los que responde simplifican enormemente el
/// despliegue transversal del layout general de la aplicacion sin generar
/// imports redundates a lo largo de los modulos.
class MyAppScaffold extends StatelessWidget {
  const MyAppScaffold({
    this.child,
    this.withMargin = true,
    this.withAppbar = true,
    this.blocCoreExt,
    super.key,
  });
  final Widget? child;
  final bool withMargin, withAppbar;
  final BlocCore<dynamic>? blocCoreExt;

  @override
  Widget build(BuildContext context) {
    final BlocCore<dynamic> blocCoreInt =
        blocCoreExt ?? blocCore; // usar para propositos de testing unicamente
    final BlocProcessing blocProcessing =
        blocCoreInt.getBlocModule<BlocProcessing>(BlocProcessing.name);
    final ResponsiveBloc responsiveBloc =
        blocCoreInt.getBlocModule<ResponsiveBloc>(ResponsiveBloc.name);
    responsiveBloc.setSizeFromContext(context);
    final DrawerMainMenuBloc drawerMainMenuBloc =
        blocCoreInt.getBlocModule<DrawerMainMenuBloc>(DrawerMainMenuBloc.name);
    final DrawerSecondaryMenuBloc drawerSecondaryMenuBloc = blocCoreInt
        .getBlocModule<DrawerSecondaryMenuBloc>(DrawerSecondaryMenuBloc.name);
    drawerSecondaryMenuBloc.isMovil = responsiveBloc.isMovil;
    drawerMainMenuBloc.drawerKey = GlobalKey<ScaffoldState>();
    final NavigatorBloc navigatorBloc =
        blocCoreInt.getBlocModule<NavigatorBloc>(NavigatorBloc.name);

    drawerSecondaryMenuBloc.isMovil = responsiveBloc.isMovil;

    return Stack(
      children: <Widget>[
        SafeArea(
          child: Scaffold(
            appBar: withAppbar
                ? MyAppBarWidget(
                    navigatorBloc: navigatorBloc,
                    drawerMainMenuBloc: drawerMainMenuBloc,
                  )
                : null,
            floatingActionButton: responsiveBloc.isMovil
                ? MyFloatingActionButtonWidget(
                    listMenuOptions: drawerSecondaryMenuBloc.listMenuOptions,
                  )
                : null,
            drawer: drawerMainMenuBloc.listMenuOptions.isEmpty
                ? null
                : MyDrawerWidget(drawerMainMenuBloc: drawerMainMenuBloc),
            key: drawerMainMenuBloc.drawerKey,
            body: responsiveBloc.isMovil
                ? child
                : Row(
                    children: <Widget>[
                      MainOptionMenuWidget(
                        responsiveBloc: responsiveBloc,
                        drawerMainMenuBloc: drawerMainMenuBloc,
                      ),
                      SecondaryMainOptionMenuWidget(
                        blocResponsive: responsiveBloc,
                        blocSecondaryDrawer: drawerSecondaryMenuBloc,
                      ),
                      Expanded(
                        child: WorkAreaWidget(
                          withMargin: withMargin,
                          responsiveBloc: responsiveBloc,
                          child: child,
                        ),
                      )
                    ],
                  ),
          ),
        ),
        LoadingPage(
          blocProcessing: blocProcessing,
          blocResponsive: responsiveBloc,
        )
      ],
    );
  }
}
