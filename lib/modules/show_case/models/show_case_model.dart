import 'artifact_model.dart';
import 'code_artifact_model.dart';
import 'properties_artifact_model.dart';
import 'use_artifact_model.dart';
import 'variant_artifact_model.dart';

class ShowCaseModel {
  const ShowCaseModel({
    required this.artifact,
    required this.codeArtifact,
    required this.propertiesArtifact,
    required this.useArtifactModel,
    required this.varianstArtifactModel,
  });

  factory ShowCaseModel.empty() {
    return ShowCaseModel(
      artifact: ArtifactModel.empty(),
      codeArtifact: <CodeArtifactModel>[],
      propertiesArtifact: <PropertiesArtifactModel>[],
      useArtifactModel: UseArtifactModel.empty(),
      varianstArtifactModel: <VariantArtifactModel>[],
    );
  }
  final ArtifactModel artifact;
  final List<CodeArtifactModel> codeArtifact;
  final UseArtifactModel useArtifactModel;
  final List<VariantArtifactModel> varianstArtifactModel;
  final List<PropertiesArtifactModel> propertiesArtifact;
}
