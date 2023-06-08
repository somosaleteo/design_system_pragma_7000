import 'package:aleteo_arquetipo/entities/entity_model.dart';

class CodeArtifactModel extends EntityModel {
  final String type;
  final String language;
  final String code;
  final String instructions;

  const CodeArtifactModel({
    required this.type,
    required this.language,
    required this.code,
    required this.instructions,
  });

  @override
  EntityModel copyWith(
      {String? typeTmp,
      String? languageTmp,
      String? codeTmp,
      String? instructionsTmp}) {
    return CodeArtifactModel(
      type: typeTmp ?? type,
      language: languageTmp ?? language,
      code: codeTmp ?? code,
      instructions: instructionsTmp ?? instructions,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'language': language,
      'code': code,
      'instructions': instructions,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is CodeArtifactModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$language$code'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return CodeArtifactModel(
      type: json['type'] ?? '',
      language: json['language'] ?? '',
      code: json['code'] ?? '',
      instructions: json['instructions'] ?? '',
    );
  }
}
