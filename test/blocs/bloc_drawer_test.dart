import 'package:aleteo_arquetipo/blocs/bloc_drawer.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/drawer_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DrawerMainMenuBloc', () {
    late DrawerMainMenuBloc bloc;
    final DrawerOptionWidget drawerOption1 = DrawerOptionWidget(
      onPressed: () {},
      title: 'Option 1',
      icondata: Icons.ac_unit,
      description: 'Description 1',
    );
    final DrawerOptionWidget drawerOption2 = DrawerOptionWidget(
      onPressed: () {},
      title: 'Option 2',
      icondata: Icons.beach_access,
      description: 'Description 2',
    );

    setUp(() {
      bloc = DrawerMainMenuBloc();
    });

    test('adds and removes menu options correctly', () {
      // Add two menu options
      bloc.addDrawerOptionMenu(
        onPressed: drawerOption1.onPressed,
        title: drawerOption1.title,
        icondata: drawerOption1.icondata,
        description: drawerOption1.description,
      );
      bloc.addDrawerOptionMenu(
        onPressed: drawerOption2.onPressed,
        title: drawerOption2.title,
        icondata: drawerOption2.icondata,
        description: drawerOption2.description,
      );
      final List<DrawerOptionWidget> expectedSize = bloc.listMenuOptions;

      expectLater(bloc.listDrawerOptionSizeStream, emits(expectedSize));

      expect(
        bloc.listMenuOptions.toString(),
        <DrawerOptionWidget>[drawerOption1, drawerOption2].toString(),
      );

      // Remove the first menu option
      bloc.removeDrawerOptionMenu(drawerOption1.title);
      expect(
        bloc.listMenuOptions.toString(),
        <DrawerOptionWidget>[drawerOption2].toString(),
      );

      // Try to remove a menu option that doesn't exist
      bloc.removeDrawerOptionMenu('Nonexistent option');
      expect(
        bloc.listMenuOptions.toString(),
        <DrawerOptionWidget>[drawerOption2].toString(),
      );
    });

    test('clears the main drawer correctly', () {
      // Add two menu options
      bloc.addDrawerOptionMenu(
        onPressed: drawerOption1.onPressed,
        title: drawerOption1.title,
        icondata: drawerOption1.icondata,
        description: drawerOption1.description,
      );
      bloc.addDrawerOptionMenu(
        onPressed: drawerOption2.onPressed,
        title: drawerOption2.title,
        icondata: drawerOption2.icondata,
        description: drawerOption2.description,
      );
      expect(
        bloc.listMenuOptions.toString(),
        <DrawerOptionWidget>[drawerOption1, drawerOption2].toString(),
      );

      // Clear the main drawer
      bloc.clearMainDrawer();
      expect(bloc.listMenuOptions.isEmpty, <String>[].isEmpty);
    });

    testWidgets('opens and closes the drawer correctly',
        (WidgetTester tester) async {
      // Ensure that the widget binding is initialized
      WidgetsFlutterBinding.ensureInitialized();
      // Create a GlobalKey to use as the drawer key
      final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

      // Set the bloc's drawerKey to the GlobalKey we just created
      bloc.drawerKey = drawerKey;

      // Wait for the widget tree to build
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: drawerKey,
            drawer: Container(),
            endDrawer: Container(),
          ),
        ),
      );

      // Open the drawer
      bloc.openDrawer();
      await tester.pumpAndSettle();
      expect(drawerKey.currentState?.isDrawerOpen, true);

      // Close the drawer
      bloc.closeDrawer();
      await tester.pumpAndSettle();
      expect(drawerKey.currentState?.isEndDrawerOpen, true);
    });
    test('four diferents functions', () {
      bloc.dispose();
      expect(bloc.listMenuOptions.isEmpty, true);
      Future<void>.delayed(const Duration(seconds: 2), () {
        bloc.listDrawerOptionSizeStream.isEmpty.then((bool val) {
          expect(val, true);
        });
      });
    });
  });
}
