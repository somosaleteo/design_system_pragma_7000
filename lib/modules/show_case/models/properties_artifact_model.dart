import 'package:aleteo_arquetipo/entities/entity_model.dart';

class PropertiesArtifactModel extends EntityModel {
  final String name;
  final String description;
  final dynamic defaultValue;
  final String language;

  const PropertiesArtifactModel({
    required this.name,
    required this.defaultValue,
    required this.description,
    required this.language,
  });

  @override
  EntityModel copyWith(
      {String? name, String? defaultValue, String? description, String? language}) {
    return PropertiesArtifactModel(
        name: name ?? this.name,
        defaultValue: defaultValue ?? this.defaultValue,
        description: description ?? this.description,
        language: language ?? this.language,
        );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'defaultValue': defaultValue,
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

  static fromJson(Map<String, dynamic> json) {
    return PropertiesArtifactModel(
      name: json['name'] ?? '',
      defaultValue: json['defaultValue'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? '',
    );
  }
}