import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/secondary_main_option_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_bloc_responsive.dart';
import '../../../mocks/mock_secondary_drawer_bloc.dart';

void main() {
  late MockResponsiveBloc mockResponsiveBloc;
  late DrawerSecondaryMenuBloc mockSecondaryDrawerBloc;

  setUp(() {
    mockResponsiveBloc = MockResponsiveBloc();
    mockSecondaryDrawerBloc = MockSecondaryDrawerBloc();

    // Agrega cualquier lógica adicional necesaria para configurar las dependencias
  });

  tearDown(() {
    mockResponsiveBloc.dispose();
    mockSecondaryDrawerBloc.dispose();
  });
  group('SecondaryMainOptionMenuWidget', () {
    testWidgets('Renderiza un SizedBox si es móvil',
        (WidgetTester tester) async {
      mockResponsiveBloc.isMovil = true;

      await tester.pumpWidget(
        MaterialApp(
          home: SecondaryMainOptionMenuWidget(
            blocResponsive: mockResponsiveBloc,
            blocSecondaryDrawer: mockSecondaryDrawerBloc,
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('Renderiza un Container si no es móvil y hay opciones de menú',
        (WidgetTester tester) async {
      mockResponsiveBloc.isMovil = false;
      mockSecondaryDrawerBloc.addSecondaryDrawerOptionMenu(
        onPressed: () {},
        icondata: Icons.add_circle,
        title: 'hola',
      );
      mockSecondaryDrawerBloc.addSecondaryDrawerOptionMenu(
        onPressed: () {},
        icondata: Icons.add_circle,
        title: 'holi',
      );
      const Key key = Key('listTileWidget');
      final Widget testChild = MaterialApp(
        home: Material(
          child: Scaffold(
            body: SecondaryMainOptionMenuWidget(
              key: key,
              blocResponsive: mockResponsiveBloc,
              blocSecondaryDrawer: mockSecondaryDrawerBloc,
            ),
          ),
        ),
      );

      await tester.pumpWidget(testChild);
      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets(
        'Renderiza un SizedBox si no es móvil y no hay opciones de menú',
        (WidgetTester tester) async {
      mockResponsiveBloc.isMovil = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Scaffold(
              body: SecondaryMainOptionMenuWidget(
                blocResponsive: mockResponsiveBloc,
                blocSecondaryDrawer: mockSecondaryDrawerBloc,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    // Agrega más pruebas para cubrir otros escenarios
  });
}
