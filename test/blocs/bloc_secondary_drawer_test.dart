// ignore_for_file: require_trailing_commas

import 'package:aleteo_arquetipo/blocs/bloc_responsive.dart';
import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/secondary_drawer_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DrawerSecondaryMenuBloc', () {
    late DrawerSecondaryMenuBloc drawerSecondaryMenuBloc;
    late ResponsiveBloc responsiveBloc;

    setUp(() {
      responsiveBloc = ResponsiveBloc();
      drawerSecondaryMenuBloc = DrawerSecondaryMenuBloc();
    });

    tearDown(() {
      drawerSecondaryMenuBloc.dispose();
      responsiveBloc.dispose();
    });

    test('Initial value of listMenuOptions is an empty list', () {
      expect(drawerSecondaryMenuBloc.listMenuOptions, isEmpty);
    });

    test('Initial value of mainCover is assets/icon.png', () {
      expect(drawerSecondaryMenuBloc.mainCover, equals('assets/icon.png'));
    });

    test('clearSecondaryMainDrawer empties listMenuOptions', () {
      drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
          onPressed: () {}, title: 'Option 1', icondata: Icons.home);

      drawerSecondaryMenuBloc.clearSecondaryMainDrawer();
      expect(drawerSecondaryMenuBloc.listMenuOptions, isEmpty);
    });

    test('addSecondaryDrawerOptionMenu adds option to listMenuOptions', () {
      drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
          onPressed: () {}, title: 'Option 1', icondata: Icons.home);

      drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
        onPressed: () {},
        title: 'Option 2',
        description: 'This is option 2',
        icondata: Icons.settings,
      );

      expect(drawerSecondaryMenuBloc.listMenuOptions.length, equals(2));
      expect(drawerSecondaryMenuBloc.listMenuOptions.last.toolTip,
          equals('Option 2'));
    });

    test(
        'addSecondaryDrawerOptionMenu removes duplicate option from listMenuOptions',
        () {
      drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
          onPressed: () {}, title: 'Option 2', icondata: Icons.home);
      drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
          onPressed: () {}, title: 'Option 3', icondata: Icons.home);
      drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
          onPressed: () {}, title: 'Option 4', icondata: Icons.home);

      drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
        onPressed: () {},
        title: 'Option 2',
        description: 'This is option 2 with a different icon',
        icondata: Icons.build,
      );
      expectLater(drawerSecondaryMenuBloc.listDrawerOptionSizeStream,
          emitsInOrder(<SecondaryDrawerOptionWidget>[]));

      expect(drawerSecondaryMenuBloc.listMenuOptions.length, equals(3));
      expect(drawerSecondaryMenuBloc.listMenuOptions.last.toolTip,
          equals('Option 2'));
      expect(drawerSecondaryMenuBloc.listMenuOptions.last.icondata,
          equals(Icons.build));
    });
  });
}
