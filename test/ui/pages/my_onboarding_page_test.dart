import 'dart:async';

import 'package:aleteo_arquetipo/ui/pages/my_onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_bloc_responsive.dart';
import '../../mocks/mock_onboarding_bloc.dart';

void main() {
  FutureOr<void> testMe() {}

  testWidgets('Test MyOnboardingPage', (WidgetTester tester) async {
    // Crear instancias de las clases mock
    final MockOnboardingBloc mockOnboardingBloc =
        MockOnboardingBloc(<void Function()>[testMe, testMe]);
    final MockResponsiveBloc mockResponsiveBloc = MockResponsiveBloc();

    // Construir el widget bajo prueba
    await tester.pumpWidget(
      MaterialApp(
        home: MyOnboardingPage(
          onboardingBloc: mockOnboardingBloc,
          responsiveBloc: mockResponsiveBloc,
        ),
      ),
    );

    // Realizar las aserciones y las pruebas necesarias
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Container), findsAtLeastNWidgets(1));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Onboarding completo'), findsOneWidget);
  });
}
