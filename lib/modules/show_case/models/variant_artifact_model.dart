import 'package:aleteo_arquetipo/entities/entity_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/code_artifact_model.dart';

class VariantArtifactModel extends EntityModel {
  const VariantArtifactModel({
    required this.type,
    required this.name,
    required this.description,
    required this.image,
    required this.codes,
  });

  final String type;
  final String name;
  final String description;
  final String image;
  final List<CodeArtifactModel> codes;

  factory VariantArtifactModel.empty() {
    return const VariantArtifactModel(
      type: '',
      description: '',
      codes: [],
      image: '',
      name: '',
    );
  }

  @override
  EntityModel copyWith({
    String? typeTmp,
    String? nameTmp,
    String? descriptionTmp,
    String? imageTmp,
    List<CodeArtifactModel>? codesTmp,
  }) {
    return VariantArtifactModel(
      type: typeTmp ?? type,
      description: descriptionTmp ?? description,
      name: nameTmp ?? name,
      image: imageTmp ?? image,
      codes: codesTmp ?? codes,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'description': description,
      'image': image,
      'codes': codes,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is VariantArtifactModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$type$description$name$codes$image'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return VariantArtifactModel(
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      codes: json['codes'] as List<CodeArtifactModel> ,
    );
  }
}
