import '../../../entities/entity_model.dart';
import 'code_artifact_model.dart';

class VariantArtifactModel extends EntityModel {
  const VariantArtifactModel({
    required this.type,
    required this.name,
    required this.description,
    required this.image,
    required this.codes,
  });

  factory VariantArtifactModel.empty() {
    return const VariantArtifactModel(
      type: '',
      description: '',
      codes: <CodeArtifactModel>[],
      image: '',
      name: '',
    );
  }

  final String type;
  final String name;
  final String description;
  final String image;
  final List<CodeArtifactModel> codes;

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

  static VariantArtifactModel fromJson(Map<String, dynamic> json) {
    return VariantArtifactModel(
      type: (json['type'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      image: (json['image'] ?? '') as String,
      codes: json['codes'] as List<CodeArtifactModel>,
    );
  }
}
