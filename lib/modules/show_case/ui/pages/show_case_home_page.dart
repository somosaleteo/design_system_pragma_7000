import 'package:aleteo_arquetipo/blocs/theme_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/widgets/menu_side.dart';
import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/bloc_responsive.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../entities/entity_bloc.dart';
import '../../blocs/create_artifact_bloc.dart';
import '../../blocs/show_case_bloc.dart';
import '../widgets/button.dart';
import 'form_artifact_page.dart';
import 'template_show_case_page.dart';

class ShowCaseHomePage extends StatefulWidget {
  const ShowCaseHomePage({
    super.key,
    required this.showCaseBloc,
    required this.createArtifactBloc,
    required this.themeBloc,
  });

  final ShowCaseBloc showCaseBloc;
  final CreateArtifactBloc createArtifactBloc;
  final ThemeBloc themeBloc;

  @override
  State<ShowCaseHomePage> createState() => _ShowCaseHomePageState();
}

class _ShowCaseHomePageState extends State<ShowCaseHomePage> {
  @override
  Widget build(BuildContext context) {
    //showCaseBloc.getShowCaseData();
    final BlocCore<dynamic> blocCoreInt = blocCore;
    final ResponsiveBloc responsiveBloc =
        blocCoreInt.getBlocModule<ResponsiveBloc>(ResponsiveBloc.name);
    responsiveBloc.setSizeFromContext(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ShowCase"),
          actions: [
            IconButton(
              onPressed: () {
                widget.themeBloc.switchThemeBetweenLigthAndDark();
                setState(() {});
              },
              icon: Icon(
                (widget.themeBloc.isThemeLight)
                    ? Icons.light_mode
                    : Icons.nightlight,
              ),
            )
          ],
        ),
        drawer: responsiveBloc.isMovil ? const MenuSide() : null,
        body: Row(
          children: [
            !responsiveBloc.isMovil
                ? const MenuSide()
                : const SizedBox.shrink(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: widget.showCaseBloc.listShowCaseModelStream,
                    builder: (context, data) {
                      if (widget.showCaseBloc.listShowCaseModel.isEmpty) {
                        return Container();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.showCaseBloc.listShowCaseModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          final showCase =
                              widget.showCaseBloc.listShowCaseModel[index];
                          return ListTile(
                            onTap: () {
                              blocCore
                                  .getBlocModule<NavigatorBloc>(
                                      NavigatorBloc.name)
                                  .pushPageWidthTitle(
                                    showCase.title,
                                    'template_show_case',
                                    TemplateShowCase(
                                      showCaseBloc: widget.showCaseBloc,
                                      showCaseModel:
                                          widget.showCaseBloc.listShowCaseModel[index],
                                    ),
                                  );
                            },
                            title: Text(showCase.title),
                          );
                        },
                      );
                    },
                  ),
                  Button(
                    title: 'New Artifact',
                    onPressed: () {
                      blocCore
                          .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                          .pushPageWidthTitle(
                            'Artifact',
                            'formArtifact',
                            FormArtifact(
                              createArtifactBloc: widget.createArtifactBloc,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
