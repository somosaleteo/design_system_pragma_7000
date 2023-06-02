import 'dart:async';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/code_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/abstractions/properties_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/button_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/button_code_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/button_properties_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/checkbox_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/checkbox_code_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/checkbox_properties_artifact.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/show_case_model.dart';

import '../../../app_config.dart';
import '../../../entities/entity_bloc.dart';
import '../../data_base/bloc/blocs.dart';

class ShowCaseBloc extends BlocModule {
  static const String name = 'showCaseBloc';
  late BlocGeneral<List<ShowCaseModel>> _listShowCaseModel;

  ShowCaseBloc() {
    _listShowCaseModel = BlocGeneral<List<ShowCaseModel>>([]);
  }
  List<ShowCaseModel> get listShowCaseModel => _listShowCaseModel.value;
  Stream<List<ShowCaseModel>> get listShowCaseModelStream =>
      _listShowCaseModel.stream;

  @override
  FutureOr<void> dispose() {}

  Future<void> getShowCaseData() async {
    final dataBaseBloc =
        blocCore.getBlocModule<DataBaseBloc>(DataBaseBloc.name);
    final response =
        await dataBaseBloc.read(module: "getShowCaseTest2", parameters: []);
    final List data = response['data'];
    List<ShowCaseModel> listShowCase = [];
    for (var showcase in data) {
      late Artifact artifactModel;
      late List<CodeArtifact> codeArtifact;
      late List<PropertiesArtifact> propertiesArtifact;

      //artefacto
      final artifact = showcase['artifact'];

      if (artifact['type'] == 'button') {
        artifactModel = ButtonArtifact.fromJson(artifact);

        //codigos
        final codes = showcase['code'];
        codeArtifact = [];
        for (var code in codes) {
          codeArtifact.add(ButtonCodeArtifact.fromJson(code));
        }

        //propiedades
        final properties = showcase['properties'];
        propertiesArtifact = [];
        for (var property in properties) {
          propertiesArtifact.add(ButtonPropertiesArtifact.fromJson(property));
        }
      }
      if (artifact['type'] == 'checkbox') {
        artifactModel = CheckBoxArtifact.fromJson(artifact);

        //codigos
        final codes = showcase['code'];
        codeArtifact = [];
        for (var code in codes) {
          codeArtifact.add(CheckBoxCodeArtifact.fromJson(code));
        }

        //propiedades
        final properties = showcase['properties'];
        propertiesArtifact = [];
        for (var property in properties) {
          propertiesArtifact.add(CheckBoxPropertiesArtifact.fromJson(property));
        }
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
