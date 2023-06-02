
import 'package:aleteo_arquetipo/entities/entity_model.dart';

abstract class Artifact extends EntityModel {
  final int width;
  final int height;
  final int radius;
  final String type;

  const Artifact({
    required this.type,
    required this.height,
    required this.radius,
    required this.width,
  });
 
}
