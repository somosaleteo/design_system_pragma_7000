import 'package:aleteo_arquetipo/ui/widgets/responsive/list_tile_drawer_widget.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_bloc_drawer.dart';

void main() {
  testWidgets('MyDrawerWidget should display correct items',
      (WidgetTester tester) async {
    // Arrange
    final MockDrawerMainMenuBloc drawerMainMenuBloc = MockDrawerMainMenuBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: MyDrawerWidget(drawerMainMenuBloc: drawerMainMenuBloc),
      ),
    );

    // Act
    final Finder mainCoverFinder = find.byType(Image);
    final Finder option1Finder = find.text('title');
    final Finder exitDrawerFinder = find.byType(ListTileExitDrawerWidget);

    // Assert
    expect(mainCoverFinder, findsOneWidget);
    expect(option1Finder, findsOneWidget);
    expect(exitDrawerFinder, findsOneWidget);
  });
}
