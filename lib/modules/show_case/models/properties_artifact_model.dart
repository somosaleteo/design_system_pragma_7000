import '../../../entities/entity_model.dart';

class PropertiesArtifactModel extends EntityModel {
  const PropertiesArtifactModel({
    required this.type,
    required this.name,
    required this.defaultValue,
    required this.description,
    required this.language,
  });
  final String type;
  final String name;
  final String description;
  final dynamic defaultValue;
  final String language;

  @override
  EntityModel copyWith({
    String? typeTmp,
    String? nameTmp,
    String? defaultValueTmp,
    String? descriptionTmp,
    String? languageTmp,
  }) {
    return PropertiesArtifactModel(
      type: typeTmp ?? type,
      name: nameTmp ?? name,
      defaultValue: defaultValueTmp ?? defaultValue,
      description: descriptionTmp ?? description,
      language: languageTmp ?? language,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'default_value': defaultValue,
      'description': description,
      'language': language,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is PropertiesArtifactModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$name$description$defaultValue'.hashCode;

  static PropertiesArtifactModel fromJson(Map<String, dynamic> json) {
    return PropertiesArtifactModel(
      type: (json['type'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      defaultValue: json['defaultValue'] ?? '',
      description: (json['description'] ?? '') as String,
      language: (json['language'] ?? '') as String,
    );
  }
}
