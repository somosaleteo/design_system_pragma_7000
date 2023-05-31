import '../../../entities/entity_model.dart';

class ShowCaseModel extends EntityModel {
  const ShowCaseModel({required this.title});
  final String title;

  @override
  ShowCaseModel copyWith({String? title}) {
    return ShowCaseModel(title: title ?? this.title);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'title': title};
  }

  @override
  bool operator ==(Object other) {
    return other is ShowCaseModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => title.hashCode;
}
