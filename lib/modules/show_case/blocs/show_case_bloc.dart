import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';

import '../../../blocs/bloc_drawer.dart';
import '../../../blocs/bloc_http.dart';
import '../../../blocs/bloc_secondary_drawer.dart';
import '../../../blocs/navigator_bloc.dart';
import '../../../entities/entity_bloc.dart';
import '../models/artifact_model.dart';
import '../models/code_artifact_model.dart';
import '../models/properties_artifact_model.dart';
import '../models/show_case_model.dart';
import '../models/use_artifact_model.dart';
import '../models/variant_artifact_model.dart';
import '../ui/pages/layout_page.dart';
import '../ui/widgets/secondary_option_menu.dart';
import 'template_show_case_model_bloc.dart';

class ShowCaseBloc extends BlocModule {
  ShowCaseBloc({
    required this.blocHttp,
    required DrawerMainMenuBloc drawerMainMenuBloc,
    required DrawerSecondaryMenuBloc drawerSecondaryMenuBloc,
    required NavigatorBloc navigatorBloc,
  }) {
    _drawerMainMenuBloc = drawerMainMenuBloc;
    _drawerSecondaryMenuBloc = drawerSecondaryMenuBloc;
    _navigatorBloc = navigatorBloc;
    _listShowCaseModel = BlocGeneral<List<ShowCaseModel>>(<ShowCaseModel>[]);
    _activeLanguage = BlocGeneral<String>('');
    _activeCode = BlocGeneral<String>('');
    addMainOption();
  }

  static const String name = 'showCaseBloc';
  late DrawerMainMenuBloc _drawerMainMenuBloc;
  late DrawerSecondaryMenuBloc _drawerSecondaryMenuBloc;
  late NavigatorBloc _navigatorBloc;
  late BlocGeneral<List<ShowCaseModel>> _listShowCaseModel;
  late BlocGeneral<String> _activeLanguage;
  late BlocGeneral<String> _activeCode;
  ShowCaseModel showCaseModelActive = ShowCaseModel.empty();
  final BlocHttp blocHttp;

  List<ShowCaseModel> get listShowCaseModel => _listShowCaseModel.value;
  Stream<List<ShowCaseModel>> get listShowCaseModelStream =>
      _listShowCaseModel.stream;

  String get activeLanguage => _activeLanguage.value;
  Stream<String> get activeLanguageStream => _activeLanguage.stream;

  String get activeCode => _activeCode.value;
  Stream<String> get activeCodeStream => _activeCode.stream;

  void switchActiveLanguage(String language) {
    _activeLanguage.value = language;
  }

  void switchActiveCode(String code) {
    _activeCode.value = code;
  }

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
    required Widget secondaryOption,
    String description = '',
    IconData icondata = Icons.question_mark,
  }) {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: onPressed,
      title: title,
      secondaryOption: secondaryOption,
      icondata: icondata,
    );
  }

  Widget secondaryOptionStartDesign() {
    final FocusNode focusNode = FocusNode();
    return Column(
      children: <Widget>[
        SecondaryOptionMenu(
          text: 'Instalación librería',
          focusNode: focusNode,
          isAutoFocus: true,
          onTap: () {
            focusNode.requestFocus();
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
      ],
    );
  }

  Widget secondaryOptionComponents() {
    return StreamBuilder<List<ShowCaseModel>>(
      stream: listShowCaseModelStream,
      builder: (BuildContext context, AsyncSnapshot<List<ShowCaseModel>> data) {
        if (listShowCaseModel.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(10.0),
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listShowCaseModel.length,
          itemBuilder: (BuildContext context, int index) {
            final ShowCaseModel showCase = listShowCaseModel[index];
            return SecondaryOptionMenu(
              text: showCase.artifact.type.capitalize(),
              onTap: () {
                showCaseModelActive = listShowCaseModel[index];
                _navigatorBloc.pushNamed(TemplateShowCaseBloc.name);
              },
            );
          },
        );
      },
    );
  }

  void addMainOption() {
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Empieza a diseñar',
      isExpanded: true,
      secondaryOption: secondaryOptionStartDesign(),
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Empieza a desarrollar',
      secondaryOption: const SizedBox.shrink(),
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Guía de estilos',
      secondaryOption: const SizedBox.shrink(),
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Componentes',
      secondaryOption: secondaryOptionComponents(),
    );
    _drawerMainMenuBloc.addDrawerOptionMenu(
      onPressed: () {},
      title: 'Componentes #Pragma7000',
      secondaryOption: const SizedBox.shrink(),
    );
  }

  String? parseUrlValidFromDrive(String googleDriveUrl) {
    final RegExp regExp = RegExp(r'\/d\/([a-zA-Z0-9_-]+)');
    final Match match = regExp.firstMatch(googleDriveUrl)!;

    if (match.groupCount >= 1) {
      final String fileId = match.group(1) ?? '';
      final String imageUrl =
          'https://drive.google.com/uc?export=download&id=$fileId';
      return imageUrl;
    } else {
      debugPrint('URL no válida de Google Drive');
      return null;
    }
  }

  Future<void> getShowCaseData() async {
    final Map<String, dynamic> response = await blocHttp.read(
      url:
          'https://script.google.com/macros/s/AKfycbxXVvtOw9NSH-zyruDPdnvlayyX2RleJ_HKvNGx_NQE7OEArcSlqBlNs_-uNa5JuNFT9A/exec',
    );
    final List<dynamic> data = response['data'] as List<dynamic>;
    final List<ShowCaseModel> listShowCase = <ShowCaseModel>[];
    for (final dynamic showcase in data) {
      late ArtifactModel artifactModel;
      late UseArtifactModel useArtifactModel;
      late List<CodeArtifactModel> codeArtifact;
      late List<VariantArtifactModel> variantsArtifactModel;
      late List<PropertiesArtifactModel> propertiesArtifact;

      final dynamic artifact = showcase['artifact'];
      final use = showcase['use'];
      final codes = showcase['codes'];
      final variants = showcase['variants'];
      final properties = showcase['properties'];

      codeArtifact = <CodeArtifactModel>[];
      propertiesArtifact = <PropertiesArtifactModel>[];
      variantsArtifactModel = <VariantArtifactModel>[];
      artifactModel = ArtifactModel.fromJson(artifact as Map<String, dynamic>);
      useArtifactModel = UseArtifactModel.fromJson(use as Map<String, dynamic>);

      for (final dynamic code in codes as List<dynamic>) {
        codeArtifact
            .add(CodeArtifactModel.fromJson(code as Map<String, dynamic>));
      }
      for (final dynamic property in properties as List<dynamic>) {
        propertiesArtifact.add(
          PropertiesArtifactModel.fromJson(property as Map<String, dynamic>),
        );
      }
      for (final dynamic variant in variants as List<dynamic>) {
        final List<CodeArtifactModel> newCodes = <CodeArtifactModel>[];
        for (final dynamic code in variant['codes'] as List<dynamic>) {
          newCodes
              .add(CodeArtifactModel.fromJson(code as Map<String, dynamic>));
        }
        variant['codes'] = newCodes;
        variantsArtifactModel.add(
          VariantArtifactModel.fromJson(variant as Map<String, dynamic>),
        );
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

  @override
  FutureOr<void> dispose() {}
}
