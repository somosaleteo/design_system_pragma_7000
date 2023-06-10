import 'dart:async';
import 'dart:core';

import 'package:aleteo_arquetipo/entities/entity_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/artifact_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/code_artifact_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/properties_artifact_model.dart';
import 'package:flutter/material.dart';

import '../../../blocs/bloc_http.dart';

class CreateArtifactBloc extends BlocModule {
  static String name = 'createArtifactBloc';
  late BlocGeneral<List<CodeArtifactModel>> _listCodeArtifactModel;
  late BlocGeneral<List<PropertiesArtifactModel>> _listPropertiesArtifactModel;
  late BlocGeneral<String> _languageExists;
  final BlocHttp blocHttp;
  CreateArtifactBloc({required this.blocHttp}) {
    _listCodeArtifactModel = BlocGeneral<List<CodeArtifactModel>>([]);
    _listPropertiesArtifactModel =
        BlocGeneral<List<PropertiesArtifactModel>>([]);
    _languageExists = BlocGeneral<String>('');
  }

  List<CodeArtifactModel> get listCodeArtifactModel =>
      _listCodeArtifactModel.value;
  Stream<List<CodeArtifactModel>> get listCodeArtifactModelStream =>
      _listCodeArtifactModel.stream;

  List<PropertiesArtifactModel> get listPropertiesArtifactModel =>
      _listPropertiesArtifactModel.value;
  Stream<List<PropertiesArtifactModel>> get listPropertiesArtifactModelStream =>
      _listPropertiesArtifactModel.stream;

  String get languageExists => _languageExists.value;
  Stream<String> get languageExistsStream => _languageExists.stream;

  @override
  FutureOr<void> dispose() {}
  String title = '';

  late ArtifactModel artifactModel;
  TextEditingController languageController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController intructionController = TextEditingController();

  void clearInputsCodeForm() {
    languageController.text = '';
    codeController.text = '';
    intructionController.text = '';
  }

  void addCode(CodeArtifactModel codeArtifactModel) {
    List<CodeArtifactModel> newList = _listCodeArtifactModel.value;
    newList.add(codeArtifactModel);
    _listCodeArtifactModel.value = newList;
  }

  void addProperties(PropertiesArtifactModel propertiesArtifactModel) {
    List<PropertiesArtifactModel> newList = _listPropertiesArtifactModel.value;
    newList.add(propertiesArtifactModel);
    _listPropertiesArtifactModel.value = newList;
  }

  void clearShowCaseModel() {
    _listCodeArtifactModel.value = [];
    _listPropertiesArtifactModel.value = [];
  }

  bool existsLanguage(String language) {
    for (var element in _listCodeArtifactModel.value) {
      if (element.language == language) {
        _languageExists.value = 'El lenguage que quiere agregar ya existe';
        return true;
      }
    }
    _languageExists.value = '';
    return false;
  }

  String? validateForm(String type, String val, bool isRequired) {
    if (isRequired && val.isEmpty) {
      return 'Debe llenar este campo';
    }

    switch (type) {
      case 'number':
        if (val is num) {
          return 'El campo debe ser un número';
        }
        break;
      default:
        return null;
    }

    return null;
  }

  Future<void> saveArtifact() async {
    List<Map<String, dynamic>> listCode = [];
    for (var code in listCodeArtifactModel) {
      listCode.add(code.toJson());
    }

    List<Map<String, dynamic>> listProperties = [];
    for (var property in listPropertiesArtifactModel) {
      listProperties.add(property.toJson());
    }
    Map<String, dynamic> body = {
      'ShowCaseModel': {
        'title': title,
        'Artifact': artifactModel.toJson(),
        'CodeArtifact': listCode,
        'PropertiesArtifact': listProperties
      }
    };

    await blocHttp.create(
      url:
          "https://script.google.com/macros/s/AKfycbxXVvtOw9NSH-zyruDPdnvlayyX2RleJ_HKvNGx_NQE7OEArcSlqBlNs_-uNa5JuNFT9A/exec",
      body: body,
    );

  }
}
