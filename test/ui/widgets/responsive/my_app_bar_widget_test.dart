import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_bloc_drawer.dart';
import '../../../mocks/mock_navigator_bloc.dart';

void main() {
  group('Testing Without leading icon', () {
    testWidgets('Test MyAppBarWidget', (WidgetTester tester) async {
      // Crea instancias de las clases mock
      final MockNavigatorBloc mockNavigatorBloc =
          MockNavigatorBloc(PageManager());
      final MockDrawerMainMenuBloc mockDrawerMainMenuBloc =
          MockDrawerMainMenuBloc();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: MyAppBarWidget(
              navigatorBloc: mockNavigatorBloc,
              drawerMainMenuBloc: mockDrawerMainMenuBloc,
            ),
          ),
        ),
      );
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Text), findsAtLeastNWidgets(2));
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });
  });
  group('Testing Without', () {
    testWidgets('Test MyAppBarWidget', (WidgetTester tester) async {
      // Crea instancias de las clases mock
      final MockNavigatorBloc mockNavigatorBloc =
          MockNavigatorBloc(PageManager());
      final MockDrawerMainMenuBloc mockDrawerMainMenuBloc =
          MockDrawerMainMenuBloc();
      mockNavigatorBloc.addPagesForDynamicLinksDirectory(
        <String, Widget>{
          'testing2': const Placeholder(),
          'testing3': const Placeholder()
        },
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: MyAppBarWidget(
              navigatorBloc: mockNavigatorBloc,
              drawerMainMenuBloc: mockDrawerMainMenuBloc,
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      final Finder menuButtonFinder = find.byIcon(Icons.menu);
      expect(menuButtonFinder, findsOneWidget);
      await tester.tap(menuButtonFinder);
      expect(mockDrawerMainMenuBloc.isOpen, true);
    });
  });
}
