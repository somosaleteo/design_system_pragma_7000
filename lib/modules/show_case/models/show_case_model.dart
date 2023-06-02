import '../../../entities/entity_model.dart';
import '../abstractions/artifact.dart';
import '../abstractions/code_artifact.dart';
import '../abstractions/properties_artifact.dart';

class ShowCaseModel extends EntityModel {
  const ShowCaseModel({
    required this.title,
    required this.artifact,
    required this.codeArtifact,
    required this.propertiesArtifact,
  });
  final String title;
  final Artifact artifact;
  final List<CodeArtifact> codeArtifact;
  final List<PropertiesArtifact> propertiesArtifact;

  @override
  ShowCaseModel copyWith({
    String? title,
    Artifact? artifact,
    List<CodeArtifact>? codeArtifact,
    List<PropertiesArtifact>? propertiesArtifact,
  }) {
    return ShowCaseModel(
        title: title ?? this.title,
        artifact: artifact ?? this.artifact,
        codeArtifact: codeArtifact ?? this.codeArtifact,
        propertiesArtifact: propertiesArtifact ?? this.propertiesArtifact);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'title': title};
  }

  @override
  bool operator ==(Object other) {
    return other is ShowCaseModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => title.hashCode;
}
