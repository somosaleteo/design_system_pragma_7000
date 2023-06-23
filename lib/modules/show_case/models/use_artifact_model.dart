import 'package:aleteo_arquetipo/entities/entity_model.dart';

class UseArtifactModel extends EntityModel {
  const UseArtifactModel({
    required this.type,
    required this.description,
    required this.recomendationImage,
    required this.recomendationDescription,
    required this.avoidImage,
    required this.avoidDescription,
  });

  final String type;
  final String description;
  final String recomendationImage;
  final String recomendationDescription;
  final String avoidImage;
  final String avoidDescription;

  factory UseArtifactModel.empty() {
    return const UseArtifactModel(
        type: '',
        description: '',
        recomendationImage: '',
        recomendationDescription: '',
        avoidImage: '',
        avoidDescription: '');
  }

  @override
  EntityModel copyWith(
      {String? typeTmp,
      String? descriptionTpm,
      String? recomendationImageTmp,
      String? recomendationDescriptionTmp,
      String? avoidImageTmp,
      String? avoidDescriptionTmp}) {
    return UseArtifactModel(
        type: typeTmp ?? type,
        description: descriptionTpm ?? description,
        recomendationImage: recomendationImageTmp ?? recomendationImage,
        recomendationDescription:
            recomendationDescriptionTmp ?? recomendationDescription,
        avoidImage: avoidImageTmp ?? avoidImage,
        avoidDescription: avoidImageTmp ?? avoidDescription);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'description': description,
      'recomendationImage': recomendationImage,
      'recomendationDescription': recomendationDescription,
      'avoidImage': avoidImage,
      'avoidDescription': avoidDescription,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is UseArtifactModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode =>
      '$type$description$recomendationImage$recomendationDescription$avoidImage$avoidDescription'
          .hashCode;

  static fromJson(Map<String, dynamic> json) {
    return UseArtifactModel(
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      avoidDescription: json['avoidDescription'] ??'',
      avoidImage: json['avoidImage'] ??'',
      recomendationDescription:json['recomendationDescription'] ?? '',
      recomendationImage: json['recomendationImage'] ?? '',
    );
  }
}
