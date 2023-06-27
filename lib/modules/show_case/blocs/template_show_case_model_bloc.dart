import 'dart:async';

import '../../../entities/entity_bloc.dart';

class TemplateShowCaseBloc extends BlocModule {

  TemplateShowCaseBloc() {
    _showCodeArtifact = BlocGeneral<bool>(false);
  }
  static const String name = 'templateShowCaseBloc';

  late BlocGeneral<bool> _showCodeArtifact;

  bool get showCodeArtifact => _showCodeArtifact.value;
  Stream<bool> get showCodeArtifactStream => _showCodeArtifact.stream;

  void switchShowCodeArtifact() {
    final bool statusTmp = _showCodeArtifact.value;
    _showCodeArtifact.value = !statusTmp;
  }

  @override
  FutureOr<void> dispose() {}
}
