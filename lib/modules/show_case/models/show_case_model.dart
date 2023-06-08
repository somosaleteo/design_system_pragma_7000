import 'artifact_model.dart';
import 'code_artifact_model.dart';
import 'properties_artifact_model.dart';

class ShowCaseModel {
  const ShowCaseModel({
    // required this.type,
    required this.title,
    required this.artifact,
    required this.codeArtifact,
    required this.propertiesArtifact,
  });
  // final String type;
  final String title;
  final ArtifactModel artifact;
  final List<CodeArtifactModel> codeArtifact;
  final List<PropertiesArtifactModel> propertiesArtifact;
}
