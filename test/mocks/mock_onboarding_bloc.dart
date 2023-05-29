import 'package:aleteo_arquetipo/blocs/onboarding_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockOnboardingBloc extends OnboardingBloc {
  MockOnboardingBloc(super.listOfOnboardingFunctions);

  @override
  String get msg => 'Onboarding completo';

  @override
  Future<void> execute(Duration duration) async {
    // Implementar el comportamiento esperado para la clase mock
  }
}
