import 'dart:async';

import 'package:flutter/material.dart';

import '../entities/entity_bloc.dart';
import '../ui/widgets/responsive/secondary_drawer_option_widget.dart';

class DrawerSecondaryMenuBloc extends BlocModule {
  DrawerSecondaryMenuBloc();
  static const String name = 'drawerSecondaryMenuBloc';
  final BlocGeneral<List<SecondaryDrawerOptionWidget>> _blocSecondary =
      BlocGeneral<List<SecondaryDrawerOptionWidget>>(
    <SecondaryDrawerOptionWidget>[],
  );
  bool isMovil = true;

  Stream<List<SecondaryDrawerOptionWidget>> get listDrawerOptionSizeStream =>
      _blocSecondary.stream;

  List<SecondaryDrawerOptionWidget> get listMenuOptions => _blocSecondary.value;

  void clearSecondaryMainDrawer() {
    _blocSecondary.value = <SecondaryDrawerOptionWidget>[];
  }

  String mainCover = 'assets/icon.png';

  void addSecondaryDrawerOptionMenu({
    required void Function() onPressed,
    required String title,
    required IconData icondata,
    String description = '',
  }) {
    final List<SecondaryDrawerOptionWidget> tmpList =
        <SecondaryDrawerOptionWidget>[];
    final SecondaryDrawerOptionWidget optionWidget =
        SecondaryDrawerOptionWidget(
      onPressed: onPressed,
      toolTip: title,
      icondata: icondata,
      secondaryMenuBloc: this,
    );
    for (final SecondaryDrawerOptionWidget option in _blocSecondary.value) {
      if (option.toolTip != title) {
        tmpList.add(option);
      }
    }
    tmpList.add(optionWidget);
    _blocSecondary.value = tmpList;
  }

  @override
  FutureOr<void> dispose() {
    _blocSecondary.dispose();
  }
}
