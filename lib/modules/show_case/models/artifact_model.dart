import 'package:aleteo_arquetipo/entities/entity_model.dart';
import 'package:flutter/material.dart';

class ArtifactModel extends EntityModel {
  const ArtifactModel({
    required this.height,
    required this.radius,
    required this.width,
    required this.image,
  });

  final int width;
  final int height;
  final int radius;
  final String image;

  @override
  EntityModel copyWith(
      {String? image, int? height, int? radius, int? width, Widget? body}) {
    return ArtifactModel(
      height: height ?? this.height,
      radius: radius ?? this.radius,
      width: width ?? this.width,
      image: image ?? this.image,
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
  int get hashCode => '$image$height$radius$width'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return ArtifactModel(
      height: json['height'] ?? 0,
      radius: json['radius'] ?? 0,
      width: json['width'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}
