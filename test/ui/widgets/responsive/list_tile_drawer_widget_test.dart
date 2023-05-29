import 'package:aleteo_arquetipo/ui/widgets/responsive/list_tile_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('general testing', () {
    testWidgets('Test ListTileExitDrawerWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            endDrawer: Drawer(),
            body: ListTileExitDrawerWidget(),
          ),
        ),
      );

      // Realizar pruebas y afirmaciones aquí
      // Por ejemplo, puedes utilizar `tester` para encontrar y verificar widgets dentro de ListTileExitDrawerWidget

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.text('Salir'), findsOneWidget);
      expect(find.text('Cerrar menu lateral'), findsOneWidget);
    });

    testWidgets('onTap - openEndDrawer', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            endDrawer: Drawer(),
            body: Builder(
              builder: (BuildContext context) {
                return const ListTileExitDrawerWidget();
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ListTileExitDrawerWidget));
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);
    });
  });
}
