import 'dart:async';

import 'package:flutter/material.dart';

import '../../../blocs/bloc_drawer.dart';
import '../../../blocs/bloc_secondary_drawer.dart';
import '../../../entities/entity_bloc.dart';

class BlocDemo extends BlocModule {
  BlocDemo({
    required DrawerMainMenuBloc drawerMainMenuBloc,
    required DrawerSecondaryMenuBloc drawerSecondaryMenuBloc,
  }) {
    _drawerMainMenuBloc = drawerMainMenuBloc;
    _drawerSecondaryMenuBloc = drawerSecondaryMenuBloc;
    addMainOption();
  }
  late DrawerMainMenuBloc _drawerMainMenuBloc;
  late DrawerSecondaryMenuBloc _drawerSecondaryMenuBloc;
  static const String name = 'BlocDemo';
  final BlocGeneral<int> _blocCounter = BlocGeneral<int>(0);

  Stream<int> get counterStream => _blocCounter.stream;

  int get counter => _blocCounter.value;

  @override
  FutureOr<void> dispose() {
    _blocCounter.dispose();
  }

  void incrementCount() {
    _blocCounter.value = _blocCounter.value + 1;
  }

  void decrementCount() {
    _blocCounter.value = _blocCounter.value - 1;
  }

  void reset() {
    _blocCounter.value = 0;
  }

  void addSecondaryDrawerOptionMenu({
    required void Function() onPressed,
    required String title,
    String description = '',
    IconData icondata = Icons.question_mark,
  }) {
    _drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
      onPressed: onPressed,
      title: title,
      icondata: icondata,
      description: description,
    );
  }

  void addDrawerOptionMenu({
    required void Function() onPressed,
    required String title,
    String description = '',
    IconData icondata = Icons.question_mark,
  }) {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: onPressed,
      description: description,
      title: title,
      icondata: icondata,
    );
  }

  void addMainOptionWithSecondaryOptions() {
    addDrawerOptionMenu(
      onPressed: () {
        addSecondaryDrawerOptionMenu(
          onPressed: incrementCount,
          title: 'Increment Counter',
          icondata: Icons.add_circle,
        );
        addSecondaryDrawerOptionMenu(
          onPressed: decrementCount,
          title: 'Decrement Counter',
          icondata: Icons.remove_circle,
        );
        addSecondaryDrawerOptionMenu(
          onPressed: reset,
          title: 'reset Counter',
          icondata: Icons.refresh,
        );
        addSecondaryDrawerOptionMenu(
          onPressed: () {
            _drawerMainMenuBloc.removeDrawerOptionMenu('Main Option');
          },
          title: 'Remove MainOption',
          icondata: Icons.remove,
        );
        addSecondaryDrawerOptionMenu(
          onPressed: () {
            _drawerMainMenuBloc.clearMainDrawer();
            addSecondaryDrawerOptionMenu(
              onPressed: () {
                addMainOption();
              },
              title: 'Add MainOption',
              icondata: Icons.add,
            );
          },
          title: 'Remove MainDrawer',
          icondata: Icons.garage,
        );
      },
      title: 'Secondary actions',
      icondata: Icons.add,
    );
  }

  void addMainOption() {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {
        addMainOptionWithSecondaryOptions();
      },
      title: 'Main Option',
      icondata: Icons.add_circle,
    );
  }
}
