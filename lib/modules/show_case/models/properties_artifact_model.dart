import 'package:aleteo_arquetipo/entities/entity_model.dart';

class PropertiesArtifactModel extends EntityModel {
  final String name;
  final String description;
  final dynamic defaultValue;

  const PropertiesArtifactModel({
    required this.name,
    required this.defaultValue,
    required this.description,
  });

  @override
  EntityModel copyWith(
      {String? name, String? defaultValue, String? description}) {
    return PropertiesArtifactModel(
        name: name ?? this.name,
        defaultValue: defaultValue ?? this.defaultValue,
        description: description ?? this.description);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'defaultValue': defaultValue,
      'description': description,
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
    );
  }
}
