import 'package:aleteo_arquetipo/entities/entity_model.dart';
import 'package:flutter/material.dart';

class ArtifactModel extends EntityModel {
  const ArtifactModel({
    required this.type,
    required this.height,
    required this.radius,
    required this.width,
  });

  final int width;
  final int height;
  final int radius;
  final String type;

  @override
  EntityModel copyWith(
      {String? type, int? height, int? radius, int? width, Widget? body}) {
    return ArtifactModel(
      type: type ?? this.type,
      height: height ?? this.height,
      radius: radius ?? this.radius,
      width: width ?? this.width,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'heigth': height,
      'radius': radius,
      'width': width,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is ArtifactModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$type$height$radius$width'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return ArtifactModel(
      type: json['type'] ?? '',
      height: json['height'] ?? 0,
      radius: json['radius'] ?? 0,
      width: json['width'] ?? 0,
    );
  }
}
