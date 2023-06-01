import 'dart:async';
import '../../../entities/entity_bloc.dart';
import '../abstractions/artifact.dart';
import '../abstractions/code_artifact.dart';
import '../abstractions/properties_artifact.dart';
import '../models/show_case_model.dart';
import 'button_artifact.dart';
import 'button_code_artifact.dart';
import 'button_properties_artifact.dart';

class ShowCaseBloc extends BlocModule {
  static const String name = 'showCaseBloc';

  @override
  FutureOr<void> dispose() {}

  ShowCaseModel getButtonShowCase() {
    final Artifact buttonArtifact = ButtonArtifact();
    final CodeArtifact buttonCodeArtifact = ButtonCodeArtifact();
    final List<PropertiesArtifact> buttonPropertiesArtifact = [
      ButtonPropertiesArtifact(
        name: "iconData",
        description: "Icono que acompaña va dentro del botón",
        defaultValue: "null",
      ),
      ButtonPropertiesArtifact(
        name: "title",
        description: "Título del botón",
        defaultValue: "Button",
      ),
      ButtonPropertiesArtifact(
        name: "width",
        description: "Ancho del botón",
        defaultValue: "100",
      ),
      ButtonPropertiesArtifact(
        name: "height",
        description: "Alto del botón",
        defaultValue: "40",
      ),
      ButtonPropertiesArtifact(
        name: "type",
        description: "Tipo del botón",
        defaultValue: "primary",
      ),
      ButtonPropertiesArtifact(
        name: "onPressed",
        description: "Función que se ejecuta cuando se presiona el botón",
        defaultValue: "null",
      ),
    ];
    return ShowCaseModel(
      title: 'Button',
      artifact: buttonArtifact,
      codeArtifact: buttonCodeArtifact,
      propertiesArtifact: buttonPropertiesArtifact,
    );
  }
}
