import 'dart:async';

import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/secondary_drawer_option_widget.dart';
import 'package:flutter/material.dart';

class MockSecondaryDrawerBloc extends DrawerSecondaryMenuBloc {
  MockSecondaryDrawerBloc();

  final StreamController<List<SecondaryDrawerOptionWidget>> _controller =
      StreamController<List<SecondaryDrawerOptionWidget>>.broadcast();

  List<SecondaryDrawerOptionWidget> _listMenuOptions =
      <SecondaryDrawerOptionWidget>[];

  @override
  Stream<List<SecondaryDrawerOptionWidget>> get listDrawerOptionSizeStream =>
      _controller.stream;

  @override
  List<SecondaryDrawerOptionWidget> get listMenuOptions => _listMenuOptions;

  @override
  void clearSecondaryMainDrawer() {
    _listMenuOptions = <SecondaryDrawerOptionWidget>[];
    _controller.add(_listMenuOptions);
  }

  @override
  void addSecondaryDrawerOptionMenu({
    required void Function() onPressed,
    required String title,
    required IconData icondata,
    String description = '',
  }) {
    final List<SecondaryDrawerOptionWidget> tmpList =
        List<SecondaryDrawerOptionWidget>.from(_listMenuOptions);
    final SecondaryDrawerOptionWidget optionWidget =
        SecondaryDrawerOptionWidget(
      onPressed: onPressed,
      toolTip: title,
      icondata: icondata,
      secondaryMenuBloc: this,
    );

    tmpList.removeWhere(
      (SecondaryDrawerOptionWidget option) => option.toolTip == title,
    );
    tmpList.add(optionWidget);

    _listMenuOptions = tmpList;
    _controller.add(_listMenuOptions);
  }

  @override
  FutureOr<void> dispose() {
    _controller.close();
  }
}
