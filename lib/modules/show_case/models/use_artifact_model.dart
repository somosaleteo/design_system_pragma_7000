import '../../../entities/entity_model.dart';

class UseArtifactModel extends EntityModel {
  const UseArtifactModel({
    required this.type,
    required this.description,
    required this.recomendationImage,
    required this.recomendationDescription,
    required this.avoidImage,
    required this.avoidDescription,
  });

  factory UseArtifactModel.empty() {
    return const UseArtifactModel(
        type: '',
        description: '',
        recomendationImage: '',
        recomendationDescription: '',
        avoidImage: '',
        avoidDescription: '',);
  }

  final String type;
  final String description;
  final String recomendationImage;
  final String recomendationDescription;
  final String avoidImage;
  final String avoidDescription;

  @override
  EntityModel copyWith(
      {String? typeTmp,
      String? descriptionTpm,
      String? recomendationImageTmp,
      String? recomendationDescriptionTmp,
      String? avoidImageTmp,
      String? avoidDescriptionTmp,}) {
    return UseArtifactModel(
        type: typeTmp ?? type,
        description: descriptionTpm ?? description,
        recomendationImage: recomendationImageTmp ?? recomendationImage,
        recomendationDescription:
            recomendationDescriptionTmp ?? recomendationDescription,
        avoidImage: avoidImageTmp ?? avoidImage,
        avoidDescription: avoidImageTmp ?? avoidDescription,);
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

  static UseArtifactModel fromJson(Map<String, dynamic> json) {
    return UseArtifactModel(
      type: (json['type'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      avoidDescription: (json['avoidDescription'] ??'') as String,
      avoidImage: (json['avoidImage'] ??'') as String,
      recomendationDescription:(json['recomendationDescription'] ?? '') as String,
      recomendationImage: (json['recomendationImage'] ?? '') as String,
    );
  }
}
