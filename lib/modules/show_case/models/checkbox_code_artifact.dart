import 'package:aleteo_arquetipo/entities/entity_model.dart';

import '../abstractions/code_artifact.dart';

class CheckBoxCodeArtifact extends CodeArtifact {
  const CheckBoxCodeArtifact({
    required super.language,
    required super.code,
  });

  @override
  EntityModel copyWith({String? language, String? code}) {
    return CheckBoxCodeArtifact(
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
    return other is CheckBoxCodeArtifact &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$language$code'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return CheckBoxCodeArtifact(
      language: json['language'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
