import 'dart:async';

import '../entities/entity_bloc.dart';

class OnboardingBloc extends BlocModule {
  OnboardingBloc(
    List<FutureOr<void> Function()> listOfOnboardingFunctions,
  ) {
    _blocOnboardingList = listOfOnboardingFunctions;
  }
  static const String name = 'onboardingBloc';
  late List<FutureOr<void> Function()> _blocOnboardingList;
  final BlocGeneral<String> _blocMsg = BlocGeneral<String>('Inicializando');

  Stream<String> get msgStream => _blocMsg.stream;

  int addFunction(FutureOr<void> Function() function) {
    _blocOnboardingList.add(function);
    return _blocOnboardingList.length;
  }

  Future<void> execute(Duration duration) async {
    await Future<void>.delayed(duration);
    final List<FutureOr<void> Function()> tmpList =
        List<FutureOr<void> Function()>.from(_blocOnboardingList);
    int length = tmpList.length;
    for (final FutureOr<void> Function() f in tmpList) {
      length--;
      await f();
      _blocMsg.value = '$length restantes';
    }
    _blocMsg.value = 'Onboarding completo';
  }

  String get msg => _blocMsg.value;

  @override
  FutureOr<void> dispose() {
    _blocMsg.dispose();
  }
}
