import 'dart:async';
import '../../../blocs/bloc_http.dart';
import '../../../entities/entity_bloc.dart';
import '../models/artifact_model.dart';
import '../models/code_artifact_model.dart';
import '../models/properties_artifact_model.dart';
import '../models/show_case_model.dart';

class ShowCaseBloc extends BlocModule {
  static const String name = 'showCaseBloc';
  late BlocGeneral<List<ShowCaseModel>> _listShowCaseModel;

  final BlocHttp blocHttp;

  ShowCaseBloc({required this.blocHttp}) {
    _listShowCaseModel = BlocGeneral<List<ShowCaseModel>>([]);
  }

  List<ShowCaseModel> get listShowCaseModel => _listShowCaseModel.value;
  Stream<List<ShowCaseModel>> get listShowCaseModelStream =>
      _listShowCaseModel.stream;

  @override
  FutureOr<void> dispose() {}

  Future<void> getShowCaseData() async {
    final response =
        await blocHttp.read(module: "getShowCaseTest2", parameters: []);
    final List data = response['data'];
    List<ShowCaseModel> listShowCase = [];
    for (var showcase in data) {
      late ArtifactModel artifactModel;
      late List<CodeArtifactModel> codeArtifact;
      late List<PropertiesArtifactModel> propertiesArtifact;

      final artifact = showcase['artifact'];
      final codes = showcase['code'];
      final properties = showcase['properties'];
      codeArtifact = [];
      propertiesArtifact = [];
      artifactModel = ArtifactModel.fromJson(artifact);
      for (var code in codes) {
        codeArtifact.add(CodeArtifactModel.fromJson(code));
      }
      for (var property in properties) {
        propertiesArtifact.add(PropertiesArtifactModel.fromJson(property));
      }
      listShowCase.add(
        ShowCaseModel(
          title: showcase['title'],
          artifact: artifactModel,
          codeArtifact: codeArtifact,
          propertiesArtifact: propertiesArtifact,
        ),
      );
      _listShowCaseModel.value = listShowCase;
    }
  }
}
