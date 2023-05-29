import 'dart:async';

import 'package:flutter/material.dart';

import '../entities/entity_bloc.dart';
import '../ui/widgets/responsive/drawer_option_widget.dart';

/// [DrawerMainMenuBloc] A BLoC for managing the main menu drawer options.
///
/// This BLoC manages a list of [DrawerOptionWidget] instances, which are used to
/// build the main menu drawer. It provides methods for adding, removing, and
/// clearing the list of options, as well as for opening and closing the drawer.
class DrawerMainMenuBloc extends BlocModule {
  DrawerMainMenuBloc();

  /// The name of this BLoC module.
  static const String name = 'drawerMainMenuBloc';
  final BlocGeneral<List<DrawerOptionWidget>> _drawerMainMenu =
      BlocGeneral<List<DrawerOptionWidget>>(<DrawerOptionWidget>[]);

  /// A global key for accessing the main menu drawer scaffold.
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  /// A stream of the current list of [DrawerOptionWidget] instances.
  Stream<List<DrawerOptionWidget>> get listDrawerOptionSizeStream =>
      _drawerMainMenu.stream;

  /// The current list of [DrawerOptionWidget] instances.
  List<DrawerOptionWidget> get listMenuOptions => _drawerMainMenu.value;

  /// Clears the main drawer by setting the list of options to an empty list.
  void clearMainDrawer() {
    _drawerMainMenu.value = <DrawerOptionWidget>[];
  }

  String mainCover = 'assets/icon.png';

  /// [addDrawerOptionMenu] Adds a new [DrawerOptionWidget] to the list of options.
  ///
  /// The [onPressed] parameter is a required callback function that will be
  /// called when the option is pressed. The [title] parameter is the title of
  /// the option, and [icondata] is the icon to be displayed alongside the
  /// title. The [description] parameter is an optional description of the
  /// option.
  void addDrawerOptionMenu({
    required VoidCallback onPressed,
    required String title,
    required IconData icondata,
    String description = '',
  }) {
    final List<DrawerOptionWidget> tmpList = <DrawerOptionWidget>[];
    final DrawerOptionWidget optionWidget = DrawerOptionWidget(
      onPressed: onPressed,
      title: title,
      icondata: icondata,
      description: description,
    );
    for (final DrawerOptionWidget option in _drawerMainMenu.value) {
      if (option.title != title) {
        tmpList.add(option);
      }
    }
    tmpList.add(optionWidget);
    _drawerMainMenu.value = tmpList;
  }

  /// [removeDrawerOptionMenu] Removes the [DrawerOptionWidget] with the given title from the list of
  /// options.
  void removeDrawerOptionMenu(String title) {
    final List<DrawerOptionWidget> tmpList = <DrawerOptionWidget>[];
    for (final DrawerOptionWidget option in _drawerMainMenu.value) {
      if (option.title.toLowerCase() != title.toLowerCase()) {
        tmpList.add(option);
      }
    }
    _drawerMainMenu.value = tmpList;
  }

  /// Opens the main menu drawer.
  void openDrawer() {
    drawerKey.currentState?.openDrawer();
  }

  /// Closes the main menu drawer.
  void closeDrawer() {
    drawerKey.currentState?.openEndDrawer();
  }

  @override
  FutureOr<void> dispose() {
    _drawerMainMenu.dispose();
  }
}
