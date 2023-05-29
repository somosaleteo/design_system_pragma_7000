import 'package:aleteo_arquetipo/ui/widgets/responsive/work_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_bloc_responsive.dart';

void main() {
  testWidgets('WorkAreaWidget with margin', (WidgetTester tester) async {
    final MockResponsiveBloc responsiveBloc = MockResponsiveBloc();
    final Widget childWidget = Container();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox.expand(
            child: WorkAreaWidget(
              withMargin: true,
              responsiveBloc: responsiveBloc,
              child: childWidget,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    // Verificar que el tamaño del área de trabajo se actualiza correctamente
    expect(
      responsiveBloc.workAreaSize,
      const Size(800, 600),
    ); // Ajusta los valores según tus necesidades

    // Verificar que el widget hijo se muestra dentro del contenedor con margen
    final Finder containerFinder = find.byType(Padding);
    expect(containerFinder, findsOneWidget);
    final Padding containerWidget = tester.widget<Padding>(containerFinder);
    expect(
      containerWidget.padding,
      const EdgeInsets.symmetric(horizontal: 16.0),
    );
    expect(containerWidget.child, childWidget);
  });

  testWidgets('WorkAreaWidget without margin', (WidgetTester tester) async {
    final MockResponsiveBloc responsiveBloc = MockResponsiveBloc();
    final Widget childWidget =
        Container(); // Puedes crear el widget que desees para las pruebas

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WorkAreaWidget(
            withMargin: false,
            responsiveBloc: responsiveBloc,
            child: childWidget,
          ),
        ),
      ),
    );

    // Verificar que el tamaño del área de trabajo se actualiza correctamente
    expect(
      responsiveBloc.workAreaSize,
      const Size(800, 600),
    ); // Ajusta los valores según tus necesidades

    // Verificar que el widget hijo se muestra directamente sin contenedor
    final Finder childFinder = find.byType(Container);
    expect(childFinder, findsOneWidget);
  });
}
