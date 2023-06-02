import 'package:aleteo_arquetipo/entities/entity_model.dart';
import 'package:flutter/material.dart';
import '../abstractions/artifact.dart';

class ButtonArtifact extends Artifact {
  const ButtonArtifact({
    required super.type,
    required super.height,
    required super.radius,
    required super.width,
  });

  @override
  EntityModel copyWith(
      {String? type, int? height, int? radius, int? width, Widget? body}) {
    return ButtonArtifact(
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
    return other is ButtonArtifact &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$type$height$radius$width'.hashCode;

  static fromJson(Map<String, dynamic> json) {
    return ButtonArtifact(
      type: json['type'] ?? '',
      height: json['height'] ?? 0,
      radius: json['radius'] ?? 0,
      width: json['width'] ?? 0,
    );
  }
}
