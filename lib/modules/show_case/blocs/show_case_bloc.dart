import 'dart:async';
import 'package:flutter/material.dart';
import '../../../blocs/bloc_drawer.dart';
import '../../../blocs/bloc_http.dart';
import '../../../blocs/navigator_bloc.dart';
import '../../../entities/entity_bloc.dart';
import '../../../blocs/bloc_secondary_drawer.dart';
import '../models/artifact_model.dart';
import '../models/show_case_model.dart';
import '../models/code_artifact_model.dart';
import '../models/properties_artifact_model.dart';
import '../ui/pages/layout_page.dart';
import '../ui/widgets/secondary_option_menu.dart';

class ShowCaseBloc extends BlocModule {
  ShowCaseBloc({
    required this.blocHttp,
    required DrawerMainMenuBloc drawerMainMenuBloc,
    required DrawerSecondaryMenuBloc drawerSecondaryMenuBloc,
    required NavigatorBloc navigatorBloc,
  }) {
    _listShowCaseModel = BlocGeneral<List<ShowCaseModel>>([]);
    _activeLanguage = BlocGeneral<String>('');
    _drawerMainMenuBloc = drawerMainMenuBloc;
    _drawerSecondaryMenuBloc = drawerSecondaryMenuBloc;
    _navigatorBloc = navigatorBloc;
    addMainOption();
  }

  static const String name = 'showCaseBloc';
  late DrawerMainMenuBloc _drawerMainMenuBloc;
  late DrawerSecondaryMenuBloc _drawerSecondaryMenuBloc;
  late NavigatorBloc _navigatorBloc;
  late BlocGeneral<List<ShowCaseModel>> _listShowCaseModel;
  late BlocGeneral<String> _activeLanguage;

  final BlocHttp blocHttp;

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
    required List<Widget> secondaryOptionList,
    String description = '',
    IconData icondata = Icons.question_mark,
  }) {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: onPressed,
      title: title,
      secondaryOptionList: secondaryOptionList,
      icondata: icondata,
    );
  }

  List<Widget> secondaryOptionStartDesign() {
    return [
      SecondaryOptionMenu(
        text: 'Instalación librería',
        onTap: () {
          _navigatorBloc.pushPageWidthTitle(
            'Empieza a usar una librería',
            'LayoutPage',
            const LayoutPage(),
          );
        },
      ),
      SecondaryOptionMenu(
        text: 'Colaboración',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Personalización',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Reutilizar componentes',
        onTap: () {},
      ),
    ];
  }

  List<Widget> secondaryOptionComponents() {
    return [
      SecondaryOptionMenu(
        text: 'Accordion',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Avatar',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Button',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Icon button',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Breadcrumbs',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Calendar',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Card',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Filters',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Inputs',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Loading',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Pagination',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Radio button',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Search',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Stepper',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Tabs',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Tables',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Tags',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Text area',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Toast',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Toggle',
        onTap: () {},
      ),
      SecondaryOptionMenu(
        text: 'Tooltip',
        onTap: () {},
      ),
    ];
  }

  void addMainOption() {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Empieza a diseñar',
      secondaryOptionList: secondaryOptionStartDesign(),
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Empieza a desarrollar',
      secondaryOptionList: [],
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Guía de estilos',
      secondaryOptionList: [],
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Componentes',
      secondaryOptionList: secondaryOptionComponents(),
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Componentes #Pragma7000',
      secondaryOptionList: [],
    );
  }

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

  @override
  FutureOr<void> dispose() {}
}
