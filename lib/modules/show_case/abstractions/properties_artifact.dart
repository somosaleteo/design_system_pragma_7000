import 'package:aleteo_arquetipo/entities/entity_model.dart';

abstract class PropertiesArtifact extends EntityModel {
  final String name;
  final String description;
  final dynamic defaultValue;

  const PropertiesArtifact({
    required this.name,
    required this.defaultValue,
    required this.description,
  });
}
