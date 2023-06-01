import 'dart:async';

import 'package:aleteo_arquetipo/entities/entity_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/code_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/properties_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/blocs/button_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/blocs/button_code_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/blocs/button_properties_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/show_case_model.dart';

class ShowCaseBloc extends BlocModule {
  static const String name = 'showCaseBloc';

  @override
  FutureOr<void> dispose() {}

  ShowCaseModel getButtonShowCase() {
    final Artifact buttonArtifact = ButtonArtifact();
    final CodeArtifact buttonCodeArtifact = ButtonCodeArtifact();
    final PropertiesArtifact buttonPropertiesArtifact =
        ButtonPropertiesArtifact();
    return ShowCaseModel(
      title: 'Button',
      artifact: buttonArtifact,
      codeArtifact: buttonCodeArtifact,
      propertiesArtifact: buttonPropertiesArtifact,
    );
  }
}
