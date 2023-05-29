import '../entities/entity_model.dart';

class ModelUser extends EntityModel {
  const ModelUser({required this.name, required this.photoUrl});
  final String name, photoUrl;

  @override
  ModelUser copyWith({String? nameTmp, String? photoUrlTmp}) {
    return ModelUser(name: nameTmp ?? name, photoUrl: photoUrlTmp ?? photoUrl);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'photourl': photoUrl};
  }

  @override
  bool operator ==(Object other) {
    return other is ModelUser &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$name$photoUrl'.hashCode;
}
