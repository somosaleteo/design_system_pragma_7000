import 'package:aleteo_arquetipo/entities/entity_model.dart';

class CodeArtifactModel extends EntityModel {
  final String type;
  final String language;
  final String code;
  final String instructions;
  final String variant;

  const CodeArtifactModel({
    required this.type,
    required this.language,
    required this.code,
    required this.instructions,
    required this.variant,
  });

  @override
  EntityModel copyWith({
    String? typeTmp,
    String? languageTmp,
    String? codeTmp,
    String? instructionsTmp,
    String? variantTmp,
  }) {
    return CodeArtifactModel(
      type: typeTmp ?? type,
      language: languageTmp ?? language,
      code: codeTmp ?? code,
      instructions: instructionsTmp ?? instructions,
      variant: variantTmp ?? variant,
    );
  }

  factory CodeArtifactModel.empty() {
    return const CodeArtifactModel(
      type: '',
      language: '',
      code: '',
      instructions: '',
      variant: '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'language': language,
      'code': code,
      'instruction': instructions,
      'variant': variant
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
      variant: json['variant'] ?? '',
    );
  }
}
