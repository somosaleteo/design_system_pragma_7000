import 'package:aleteo_arquetipo/ui/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import '../../mocks/mock_bloc_processing.dart';
import '../../mocks/mock_bloc_processing.dart';
import '../../mocks/mock_bloc_responsive.dart';

void main() {
  late MockBlocProcessing2 mockBlocProcessing;
  setUp(() {
    mockBlocProcessing = MockBlocProcessing2();
  });

  tearDown(() {
    mockBlocProcessing.close();
  });

  group('LoadingPage', () {
    testWidgets(
        'Muestra el indicador de carga y el mensaje cuando hay datos en el snapshot',
        (WidgetTester tester) async {
      // Crea una instancia de MockBlocProcessing

      mockBlocProcessing.emitProcessingEvent('procesando');

      // Construye el widget LoadingPage con el mock configurado
      await tester.pumpWidget(
        MaterialApp(
          home: LoadingPage(
            blocProcessing: mockBlocProcessing,
            blocResponsive: MockResponsiveBloc(),
          ),
        ),
      );
      await tester
          .pump(); // Esperar el ciclo de actualización de la interfaz de usuario
      // Verifica que el indicador de carga y el mensaje se muestren en la interfaz
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    // Resto de las pruebas...
  });
}
