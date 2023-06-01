import '../abstractions/code_artifact.dart';

class ButtonCodeArtifact extends CodeArtifact {
  @override
  Map<String, String> codes = {
    'Dart': '''Button(
        title: "Boton de prueba",
        width: 150,
        height: 40,
        type: "primary",
        onPressed: null,
    )''',
  };
}
