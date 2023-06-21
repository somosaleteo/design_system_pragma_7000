import 'dart:async';
import 'package:aleteo_arquetipo/modules/show_case/models/use_artifact_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/variant_artifact_model.dart';
import 'package:flutter/material.dart';

import '../../../blocs/bloc_http.dart';
import '../../../entities/entity_bloc.dart';
import '../models/artifact_model.dart';
import '../models/code_artifact_model.dart';
import '../models/properties_artifact_model.dart';
import '../models/show_case_model.dart';

class ShowCaseBloc extends BlocModule {
  static const String name = 'showCaseBloc';
  late BlocGeneral<List<ShowCaseModel>> _listShowCaseModel;
  late BlocGeneral<String> _activeLanguage;
  late BlocGeneral<String> _activeCode;
  ShowCaseModel showCaseModelActive = ShowCaseModel.empty();
  final BlocHttp blocHttp;

  ShowCaseBloc({required this.blocHttp}) {
    _listShowCaseModel = BlocGeneral<List<ShowCaseModel>>([]);
    _activeLanguage = BlocGeneral<String>('');
    _activeCode = BlocGeneral<String>('');
  }

  List<ShowCaseModel> get listShowCaseModel => _listShowCaseModel.value;
  Stream<List<ShowCaseModel>> get listShowCaseModelStream =>
      _listShowCaseModel.stream;

  String get activeLanguage => _activeLanguage.value;
  Stream<String> get activeLanguageStream => _activeLanguage.stream;

  String get activeCode => _activeCode.value;
  Stream<String> get activeCodeStream => _activeCode.stream;

  @override
  FutureOr<void> dispose() {}

  void switchActiveLanguage(String language) {
    _activeLanguage.value = language;
  }

  void switchActiveCode(String code) {
    _activeCode.value = code;
  }

  String? parseUrlValidFromDrive(String googleDriveUrl) {
    RegExp regExp = RegExp(r'\/d\/([a-zA-Z0-9_-]+)');
    Match match = regExp.firstMatch(googleDriveUrl) as Match;

    if (match.groupCount >= 1) {
      String fileId = match.group(1) ?? '';
      String imageUrl =
          'https://drive.google.com/uc?export=download&id=$fileId';
      return imageUrl;
    } else {
      debugPrint('URL no válida de Google Drive');
      return null;
    }
  }

  Future<void> getShowCaseData() async {
    final response = await blocHttp.read(
        url:
            "https://script.google.com/macros/s/AKfycbxXVvtOw9NSH-zyruDPdnvlayyX2RleJ_HKvNGx_NQE7OEArcSlqBlNs_-uNa5JuNFT9A/exec");
    final List data = response['data'];
    List<ShowCaseModel> listShowCase = [];
    for (var showcase in data) {
      late ArtifactModel artifactModel;
      late UseArtifactModel useArtifactModel;
      late List<CodeArtifactModel> codeArtifact;
      late List<VariantArtifactModel> variantsArtifactModel;
      late List<PropertiesArtifactModel> propertiesArtifact;

      final artifact = showcase['artifact'];
      final use = showcase['use'];
      final codes = showcase['codes'];
      final variants = showcase['variants'];
      final properties = showcase['properties'];

      codeArtifact = [];
      propertiesArtifact = [];
      variantsArtifactModel = [];
      artifactModel = ArtifactModel.fromJson(artifact);
      useArtifactModel = UseArtifactModel.fromJson(use);

      for (var code in codes) {
        codeArtifact.add(CodeArtifactModel.fromJson(code));
      }
      for (var property in properties) {
        propertiesArtifact.add(PropertiesArtifactModel.fromJson(property));
      }
      for (var variant in variants) {
        List<CodeArtifactModel> newCodes = [];
        for (var code in variant['codes']) {
          newCodes.add(CodeArtifactModel.fromJson(code));
        }
        variant['codes'] = newCodes;
        variantsArtifactModel.add(VariantArtifactModel.fromJson(variant));
      }
      listShowCase.add(
        ShowCaseModel(
          artifact: artifactModel,
          useArtifactModel: useArtifactModel,
          codeArtifact: codeArtifact,
          varianstArtifactModel: variantsArtifactModel,
          propertiesArtifact: propertiesArtifact,
        ),
      );
      _listShowCaseModel.value = listShowCase;
    }
  }
}
