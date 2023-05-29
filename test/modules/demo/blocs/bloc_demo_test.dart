import 'package:aleteo_arquetipo/blocs/bloc_drawer.dart';
import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/modules/demo/blocs/bloc_demo.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/drawer_option_widget.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/secondary_drawer_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_bloc_drawer.dart';
import '../../../mocks/mock_secondary_drawer_bloc.dart';

class MockDrawerMainMenuBlocInternal extends DrawerMainMenuBloc {}

class MockDrawerSecondaryMenuBlocInternal extends DrawerSecondaryMenuBloc {
  MockDrawerSecondaryMenuBlocInternal();
}

void main() {
  group('Testing blocDemo', () {
    late BlocDemo blocDemo;
    late MockDrawerMainMenuBlocInternal mockDrawerMainMenuBloc;
    late MockDrawerSecondaryMenuBlocInternal mockDrawerSecondaryMenuBloc;
    setUp(() {
      mockDrawerMainMenuBloc = MockDrawerMainMenuBlocInternal();
      mockDrawerSecondaryMenuBloc = MockDrawerSecondaryMenuBlocInternal();
      blocDemo = BlocDemo(
        drawerMainMenuBloc: mockDrawerMainMenuBloc,
        drawerSecondaryMenuBloc: mockDrawerSecondaryMenuBloc,
      );
    });
    test('Testing add drawerOptions', () async {
      blocDemo.addMainOption();
      expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
      mockDrawerMainMenuBloc.clearMainDrawer();
      blocDemo.addMainOptionWithSecondaryOptions();
      expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
      mockDrawerMainMenuBloc.clearMainDrawer();
      blocDemo.addDrawerOptionMenu(
        onPressed: () {},
        title: 'test',
      );
      expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
      mockDrawerSecondaryMenuBloc.clearSecondaryMainDrawer();
      blocDemo.addSecondaryDrawerOptionMenu(onPressed: () {}, title: 'title');
      expect(mockDrawerSecondaryMenuBloc.listMenuOptions.isNotEmpty, true);
    });
    test('Testing counter functions', () async {
      expect(blocDemo.counter, equals(0));
      expect(blocDemo.counter, isA<int>());
      blocDemo.incrementCount();
      expect(blocDemo.counter, equals(1));
      blocDemo.incrementCount();
      expectLater(blocDemo.counterStream, emitsInOrder(<int>[2]));
      blocDemo.decrementCount();
      expect(blocDemo.counter, equals(1));
      expectLater(blocDemo.counterStream, emitsInOrder(<int>[1]));
      blocDemo.reset();
      expect(blocDemo.counter, equals(0));
      expectLater(blocDemo.counterStream, emitsInOrder(<int>[0]));
    });

    test('Main BlocDemo stream is disposed', () {
      final Stream<int> stream = blocDemo.counterStream;

      blocDemo.dispose();
      expect(stream.isBroadcast, false);
    });

    group('Testing blocDemo', () {
      late BlocDemo blocDemo;
      late MockDrawerMainMenuBlocInternal mockDrawerMainMenuBloc;
      late MockDrawerSecondaryMenuBlocInternal mockDrawerSecondaryMenuBloc;
      setUp(() {
        mockDrawerMainMenuBloc = MockDrawerMainMenuBlocInternal();
        mockDrawerSecondaryMenuBloc = MockDrawerSecondaryMenuBlocInternal();
        blocDemo = BlocDemo(
          drawerMainMenuBloc: mockDrawerMainMenuBloc,
          drawerSecondaryMenuBloc: mockDrawerSecondaryMenuBloc,
        );
      });
      test('Testing add main option with secondary options', () async {
        blocDemo.addMainOptionWithSecondaryOptions();

        // Check that the main option was added
        expect(mockDrawerMainMenuBloc.listMenuOptions.isNotEmpty, true);
        expect(
          mockDrawerMainMenuBloc.listMenuOptions[0].title.isNotEmpty,
          true,
        );
        expect(
          mockDrawerMainMenuBloc.listMenuOptions[0].icondata,
          Icons.add_circle,
        );
        // Remove the main option
        mockDrawerMainMenuBloc.listMenuOptions[0].onPressed();
        mockDrawerMainMenuBloc.listMenuOptions[1].onPressed();
        await Future<void>.delayed(Duration.zero);

        // Check that the secondary options were added
        expect(mockDrawerSecondaryMenuBloc.listMenuOptions.length, 5);
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[0].toolTip,
          'Increment Counter',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[0].icondata,
          Icons.add_circle,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[1].toolTip,
          'Decrement Counter',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[1].icondata,
          Icons.remove_circle,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[2].toolTip,
          'reset Counter',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[2].icondata,
          Icons.refresh,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[3].toolTip,
          'Remove MainOption',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[3].icondata,
          Icons.remove,
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[4].toolTip,
          'Remove MainDrawer',
        );
        expect(
          mockDrawerSecondaryMenuBloc.listMenuOptions[4].icondata,
          Icons.garage,
        );

        // Remove the main option
        mockDrawerMainMenuBloc.listMenuOptions[1].onPressed();
        await Future<void>.delayed(Duration.zero);
      });
      test('should remove main option from main menu', () {
        blocDemo.addMainOptionWithSecondaryOptions();

        void onPressed() {
          mockDrawerMainMenuBloc.removeDrawerOptionMenu('Main Option');
        }

        const String title = 'Remove MainOption';
        const IconData icondata = Icons.remove;

        blocDemo.addSecondaryDrawerOptionMenu(
          onPressed: onPressed,
          title: title,
          icondata: icondata,
        );

        final List<DrawerOptionWidget> mainMenuOptions =
            mockDrawerMainMenuBloc.listMenuOptions;
        expect(mainMenuOptions.length, 2);

        // Invoke the onPressed callback
        onPressed();

        final List<DrawerOptionWidget> updatedMainMenuOptions =
            mockDrawerMainMenuBloc.listMenuOptions;
        expect(updatedMainMenuOptions.length, 1);
        expect(updatedMainMenuOptions[0].title, 'Secondary actions');
        expect(updatedMainMenuOptions[0].icondata, Icons.add);
      });
    });

    tearDown(() {
      blocDemo.dispose();
    });
  });

  group('BlocDemo', () {
    late MockDrawerMainMenuBloc mockDrawerMainMenuBloc;
    late MockSecondaryDrawerBloc mockSecondaryDrawerBloc;
    late BlocDemo blocDemo;

    setUp(() {
      mockDrawerMainMenuBloc = MockDrawerMainMenuBloc();
      mockSecondaryDrawerBloc = MockSecondaryDrawerBloc();
      blocDemo = BlocDemo(
        drawerMainMenuBloc: mockDrawerMainMenuBloc,
        drawerSecondaryMenuBloc: mockSecondaryDrawerBloc,
      );
    });

    tearDown(() {
      blocDemo.dispose();
    });

    test('should increment counter', () {
      blocDemo.incrementCount();
      expect(blocDemo.counter, 1);
    });

    test('should decrement counter', () {
      blocDemo.decrementCount();
      expect(blocDemo.counter, -1);
    });

    test('should reset counter', () {
      blocDemo.reset();
      expect(blocDemo.counter, 0);
    });

    test('should add secondary drawer option menu', () {
      void onPressed() {}
      const String title = 'Test Title';
      const IconData icondata = Icons.add_business;
      const String description = 'Test Description';

      blocDemo.addSecondaryDrawerOptionMenu(
        onPressed: onPressed,
        title: title,
        icondata: icondata,
        description: description,
      );

      final List<SecondaryDrawerOptionWidget> secondaryMenuOptions =
          mockSecondaryDrawerBloc.listMenuOptions;
      expect(secondaryMenuOptions.length, 1);
      expect(secondaryMenuOptions[0].toolTip, title);
      expect(secondaryMenuOptions[0].icondata, icondata);
      // expect(secondaryMenuOptions[0].description, description);
    });

    test('should add drawer option menu with secondary options', () {
      blocDemo.addMainOptionWithSecondaryOptions();

      final List<DrawerOptionWidget> mainMenuOptions =
          mockDrawerMainMenuBloc.listMenuOptions;
      expect(mainMenuOptions.length, 1);

      void onPressed() {}
      const String title = 'Increment Counter';
      const IconData icondata = Icons.add_circle;

      blocDemo.addSecondaryDrawerOptionMenu(
        onPressed: onPressed,
        title: title,
        icondata: icondata,
      );

      final List<SecondaryDrawerOptionWidget> secondaryMenuOptions =
          mockSecondaryDrawerBloc.listMenuOptions;
      expect(secondaryMenuOptions.length, 1);
      expect(secondaryMenuOptions[0].toolTip, title);
      expect(secondaryMenuOptions[0].icondata, icondata);
    });

    test('should add main option', () {
      blocDemo.addMainOption();

      final List<DrawerOptionWidget> mainMenuOptions =
          mockDrawerMainMenuBloc.listMenuOptions;
      expect(mainMenuOptions.length, 1);
      expect(mainMenuOptions[0].title, 'title');
      expect(mainMenuOptions[0].icondata, Icons.add);
    });
  });
}
