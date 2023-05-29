import 'package:aleteo_arquetipo/blocs/bloc_drawer.dart';
import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/modules/demo/blocs/bloc_demo.dart';
import 'package:aleteo_arquetipo/modules/demo/ui/pages/demo_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test DemoHomePage widget', (WidgetTester tester) async {
    final BlocDemo blocDemo = BlocDemo(
      drawerMainMenuBloc: DrawerMainMenuBloc(),
      drawerSecondaryMenuBloc: DrawerSecondaryMenuBloc(),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: DemoHomePage(
          blocDemo: blocDemo,
        ),
      ),
    );

    // Verify that the widget displays the correct counter value

    expect(find.text('0'), findsOneWidget);
  });
  testWidgets('Test DemoHomePage with myscaffold', (WidgetTester tester) async {
    final BlocDemo blocDemo = BlocDemo(
      drawerMainMenuBloc: DrawerMainMenuBloc(),
      drawerSecondaryMenuBloc: DrawerSecondaryMenuBloc(),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: DemoHomePage(
          blocDemo: blocDemo,
          isTesting: true,
        ),
      ),
    );

    // Verify that the widget displays the correct counter value

    expect(find.text('0'), findsOneWidget);
  });
}
