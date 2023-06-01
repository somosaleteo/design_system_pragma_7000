import '../abstractions/properties_artifact.dart';

class ButtonPropertiesArtifact extends PropertiesArtifact {
  @override
  String defaultValue = 'DefaultValue';

  @override
  String description = 'Description';

  @override
  String name = 'Name';

  ButtonPropertiesArtifact({
    required this.name,
    required this.description,
    required this.defaultValue,
  });
}
