import 'package:aleteo_arquetipo/entities/entity_model.dart';

class CodeArtifactModel extends EntityModel {
  final String language;
  final String code;

  const CodeArtifactModel({
    required this.language,
    required this.code,
  });

  @override
  EntityModel copyWith({String? language, String? code}) {
    return CodeArtifactModel(
        language: language ?? this.language, code: code ?? this.code);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'language': language,
      'code': code,
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
      language: json['language'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
