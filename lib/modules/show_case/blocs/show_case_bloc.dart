import 'dart:async';
import 'package:flutter/material.dart';
import '../../../blocs/bloc_drawer.dart';
import '../../../blocs/bloc_http.dart';
import '../../../blocs/bloc_secondary_drawer.dart';
import '../../../entities/entity_bloc.dart';
import '../models/artifact_model.dart';
import '../models/code_artifact_model.dart';
import '../models/properties_artifact_model.dart';
import '../models/show_case_model.dart';

class ShowCaseBloc extends BlocModule {
  static const String name = 'showCaseBloc';
  late BlocGeneral<List<ShowCaseModel>> _listShowCaseModel;
  late BlocGeneral<String> _activeLanguage;
  late DrawerMainMenuBloc _drawerMainMenuBloc;
  late DrawerSecondaryMenuBloc _drawerSecondaryMenuBloc;

  final BlocHttp blocHttp;

  ShowCaseBloc({
    required this.blocHttp,
    required DrawerMainMenuBloc drawerMainMenuBloc,
    required DrawerSecondaryMenuBloc drawerSecondaryMenuBloc,
  }) {
    _listShowCaseModel = BlocGeneral<List<ShowCaseModel>>([]);
    _activeLanguage = BlocGeneral<String>('');
    _drawerMainMenuBloc = drawerMainMenuBloc;
    _drawerSecondaryMenuBloc = drawerSecondaryMenuBloc;
    addMainOption();
  }

  List<ShowCaseModel> get listShowCaseModel => _listShowCaseModel.value;
  Stream<List<ShowCaseModel>> get listShowCaseModelStream =>
      _listShowCaseModel.stream;

  String get activeLanguage => _activeLanguage.value;
  Stream<String> get activeLanguageStream => _activeLanguage.stream;

  void addSecondaryDrawerOptionMenu({
    required void Function() onPressed,
    required String title,
    String description = '',
    IconData icondata = Icons.question_mark,
  }) {
    _drawerSecondaryMenuBloc.addSecondaryDrawerOptionMenu(
      onPressed: onPressed,
      title: title,
      icondata: icondata,
      description: description,
    );
  }

  void addDrawerOptionMenu({
    required void Function() onPressed,
    required String title,
    String description = '',
    IconData icondata = Icons.question_mark,
  }) {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: onPressed,
      title: title,
      icondata: icondata,
    );
  }

  void addMainOptionWithSecondaryOptions() {
    addSecondaryDrawerOptionMenu(
      onPressed: () {},
      title: 'Increment Counter',
      icondata: Icons.add_circle,
    );
    addSecondaryDrawerOptionMenu(
      onPressed: () {},
      title: 'Decrement Counter',
      icondata: Icons.remove_circle,
    );
    addSecondaryDrawerOptionMenu(
      onPressed: () {},
      title: 'reset Counter',
      icondata: Icons.refresh,
    );
    addSecondaryDrawerOptionMenu(
      onPressed: () {
        _drawerMainMenuBloc.removeDrawerOptionMenu('Main Option');
      },
      title: 'Remove MainOption',
      icondata: Icons.remove,
    );
    addSecondaryDrawerOptionMenu(
      onPressed: () {
        _drawerMainMenuBloc.clearMainDrawer();
        addSecondaryDrawerOptionMenu(
          onPressed: () {
            addMainOption();
          },
          title: 'Add MainOption',
          icondata: Icons.add,
        );
      },
      title: 'Remove MainDrawer',
      icondata: Icons.garage,
    );
  }

  void addMainOption() {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {
        addMainOptionWithSecondaryOptions();
      },
      title: 'Empieza a diseñar',
      icondata: Icons.add_circle,
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {
        addMainOptionWithSecondaryOptions();
      },
      title: 'Empieza a desarrollar',
      icondata: Icons.add_circle,
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {
        addMainOptionWithSecondaryOptions();
      },
      title: 'Guía de estilos',
      icondata: Icons.add_circle,
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {
        addMainOptionWithSecondaryOptions();
      },
      title: 'Componentes',
      icondata: Icons.add_circle,
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {
        addMainOptionWithSecondaryOptions();
      },
      title: 'Componentes #Pragma7000',
      icondata: Icons.add_circle,
    );
  }

  @override
  FutureOr<void> dispose() {}

  void switchActiveLanguage(String language) {
    _activeLanguage.value = language;
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
