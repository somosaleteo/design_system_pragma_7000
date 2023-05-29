import 'dart:async';

import 'package:aleteo_arquetipo/blocs/onboarding_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingBloc', () {
    late List<FutureOr<void> Function()> listOfOnboardingFunctions;
    late OnboardingBloc onboardingBloc;

    setUp(() {
      listOfOnboardingFunctions = <void Function()>[
        () => Future<void>.value(),
        () => Future<void>.value(),
        () => Future<void>.value(),
      ];

      onboardingBloc = OnboardingBloc(listOfOnboardingFunctions);
    });

    test('addFunction() should add a function to the list', () {
      onboardingBloc.addFunction(() => Future<void>.value());
    });

    test('execute() should execute all the onboarding functions', () async {
      const Duration expectedDuration = Duration(milliseconds: 50);

      onboardingBloc.execute(expectedDuration);

      await Future<void>.delayed(expectedDuration);

      expect(onboardingBloc.msg.isNotEmpty, true);
    });

    test('dispose() should dispose of the message stream', () {
      onboardingBloc.dispose();
    });
  });
}
