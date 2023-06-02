import 'package:aleteo_arquetipo/entities/entity_model.dart';

import '../abstractions/properties_artifact.dart';

class ButtonPropertiesArtifact extends PropertiesArtifact {
  const ButtonPropertiesArtifact({
    required super.name,
    required super.defaultValue,
    required super.description,
  });

  @override
  EntityModel copyWith(
      {String? name, String? defaultValue, String? description}) {
    return ButtonPropertiesArtifact(
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
    return other is ButtonPropertiesArtifact &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$name$description$defaultValue'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return ButtonPropertiesArtifact(
      name: json['name'] ?? '',
      defaultValue: json['defaultValue'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
