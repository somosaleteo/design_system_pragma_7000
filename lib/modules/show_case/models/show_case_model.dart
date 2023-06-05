import 'artifact_model.dart';
import 'code_artifact_model.dart';
import 'properties_artifact_model.dart';

class ShowCaseModel {
  const ShowCaseModel({
    required this.title,
    required this.artifact,
    required this.codeArtifact,
    required this.propertiesArtifact,
  });
  final String title;
  final ArtifactModel artifact;
  final List<CodeArtifactModel> codeArtifact;
  final List<PropertiesArtifactModel> propertiesArtifact;
}
