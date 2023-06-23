import 'package:aleteo_arquetipo/entities/entity_model.dart';

class ArtifactModel extends EntityModel {
  const ArtifactModel({
    required this.type,
    required this.image,
    required this.description,
    required this.anatomyImage,
  });

  final String type;
  final String image;
  final String description;
  final String anatomyImage;

  factory ArtifactModel.empty() {
    return const ArtifactModel(
      anatomyImage: '',
      description: '',
      image: '',
      type: '',
    );
  }

  @override
  EntityModel copyWith(
      {String? typeTmp,
      String? anatomyImageTpm,
      String? descriptionTpm,
      String? imageTmp}) {
    return ArtifactModel(
      type: typeTmp ?? type,
      image: imageTmp ?? image,
      anatomyImage: anatomyImageTpm ?? anatomyImage,
      description: descriptionTpm ?? description,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'image': image,
      'anatomyImage': anatomyImage
    };
  }

  @override
  bool operator ==(Object other) {
    return other is ArtifactModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$type$image$anatomyImage$description'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return ArtifactModel(
      type: json['type'] ?? '',
      image: json['image'] ?? '',
      anatomyImage: json['anatomyImage'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
