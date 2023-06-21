import 'package:aleteo_arquetipo/modules/show_case/models/use_artifact_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/variant_artifact_model.dart';

import 'artifact_model.dart';
import 'code_artifact_model.dart';
import 'properties_artifact_model.dart';

class ShowCaseModel {
  const ShowCaseModel({
    required this.artifact,
    required this.codeArtifact,
    required this.propertiesArtifact,
    required this.useArtifactModel,
    required this.varianstArtifactModel,
  });
  final ArtifactModel artifact;
  final List<CodeArtifactModel> codeArtifact;
  final UseArtifactModel useArtifactModel;
  final List<VariantArtifactModel> varianstArtifactModel;
  final List<PropertiesArtifactModel> propertiesArtifact;

  factory ShowCaseModel.empty() {
    return ShowCaseModel(
      artifact: ArtifactModel.empty(),
      codeArtifact: [],
      propertiesArtifact: [],
      useArtifactModel: UseArtifactModel.empty(),
      varianstArtifactModel: [],
    );
  }
}
