import 'package:aleteo_arquetipo/entities/entity_model.dart';

class ArtifactModel extends EntityModel {
  const ArtifactModel({
    required this.type,
    required this.height,
    required this.radius,
    required this.width,
    required this.image,
  });

  final String type;
  final int width;
  final int height;
  final int radius;
  final String image;

  factory ArtifactModel.empty() {
    return const ArtifactModel(
        type: '', height: 0, radius: 0, width: 0, image: '');
  }

  @override
  EntityModel copyWith(
      {String? typeTmp,
      int? heightTmp,
      int? radiusTmp,
      int? widthTmp,
      String? imageTmp}) {
    return ArtifactModel(
      type: typeTmp ?? type,
      height: heightTmp ?? height,
      radius: radiusTmp ?? radius,
      width: widthTmp ?? width,
      image: imageTmp ?? image,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'heigth': height,
      'radius': radius,
      'width': width,
      'image': image,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is ArtifactModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$type$image$height$radius$width'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return ArtifactModel(
      type: json['type'] ?? '',
      height: json['height'] ?? 0,
      radius: json['radius'] ?? 0,
      width: json['width'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}
