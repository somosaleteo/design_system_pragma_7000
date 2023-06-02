import 'package:aleteo_arquetipo/entities/entity_model.dart';

abstract class CodeArtifact extends EntityModel {
  final String language;
  final String code;

  const CodeArtifact({
    required this.language,
    required this.code,
  });
}
