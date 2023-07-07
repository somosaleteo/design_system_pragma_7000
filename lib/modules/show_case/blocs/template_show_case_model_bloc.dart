import 'dart:async';

import '../../../entities/entity_bloc.dart';

class TemplateShowCaseBloc extends BlocModule {
  TemplateShowCaseBloc() {
    _showCodeArtifact = <BlocGeneral<bool>>[];
  }
  static const String name = 'templateShowCaseBloc';

  late List<BlocGeneral<bool>> _showCodeArtifact;

  bool getShowCodeArtifact(int index) {
    if (index >= _showCodeArtifact.length) {
      _showCodeArtifact.add(BlocGeneral<bool>(false));
    }
    return _showCodeArtifact[index].value;
  }

  Stream<bool> getShowCodeArtifactStream(int index) {
    if (index >= _showCodeArtifact.length) {
      _showCodeArtifact.add(BlocGeneral<bool>(false));
    }
    return _showCodeArtifact[index].stream;
  }

  void switchShowCodeArtifact(int index) {
    if (index >= _showCodeArtifact.length) {
      _showCodeArtifact.add(BlocGeneral<bool>(false));
    }
    final bool statusTmp = _showCodeArtifact[index].value;
    _showCodeArtifact[index].value = !statusTmp;
  }

  @override
  FutureOr<void> dispose() {
    for (final BlocGeneral<bool> bloc in _showCodeArtifact) {
      bloc.dispose();
    }
  }
}
