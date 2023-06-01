import 'package:aleteo_arquetipo/modules/show_case/abstractions/artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/code_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/properties_artifact.dart';

import '../../../entities/entity_model.dart';

class ShowCaseModel extends EntityModel {
  const ShowCaseModel({
    required this.title,
    required this.artifact,
    required this.codeArtifact,
    required this.propertiesArtifact,
  });
  final String title;
  final Artifact artifact;
  final CodeArtifact codeArtifact;
  final PropertiesArtifact propertiesArtifact;

  @override
  ShowCaseModel copyWith({
    String? title,
    Artifact? artifact,
    CodeArtifact? codeArtifact,
    PropertiesArtifact? propertiesArtifact,
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
