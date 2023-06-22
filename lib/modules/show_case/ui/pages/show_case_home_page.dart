import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/bloc_responsive.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../blocs/theme_bloc.dart';
import '../../../../entities/entity_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/create_artifact_bloc.dart';
import '../../blocs/show_case_bloc.dart';
import '../widgets/button.dart';
import 'form_artifact_page.dart';
import 'template_show_case_page.dart';

class ShowCaseHomePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    //showCaseBloc.getShowCaseData();
    final BlocCore<dynamic> blocCoreInt = blocCore;
    final ResponsiveBloc responsiveBloc =
        blocCoreInt.getBlocModule<ResponsiveBloc>(ResponsiveBloc.name);
    responsiveBloc.setSizeFromContext(context);
    return MyAppScaffold(
      withAppbar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: IconButton(
                onPressed: () {
                  themeBloc.switchThemeBetweenLigthAndDark();
                },
                icon: Icon(
                  (themeBloc.isThemeLight)
                      ? Icons.light_mode
                      : Icons.nightlight,
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: showCaseBloc.listShowCaseModelStream,
            builder: (context, data) {
              if (showCaseBloc.listShowCaseModel.isEmpty) {
                return Container();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: showCaseBloc.listShowCaseModel.length,
                itemBuilder: (BuildContext context, int index) {
                  final showCase =
                      showCaseBloc.listShowCaseModel[index];
                  return ListTile(
                    onTap: () {
                      blocCore
                          .getBlocModule<NavigatorBloc>(
                              NavigatorBloc.name)
                          .pushPageWidthTitle(
                            showCase.title,
                            'template_show_case',
                            TemplateShowCase(
                              showCaseBloc: showCaseBloc,
                              showCaseModel: showCaseBloc.listShowCaseModel[index],
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
                      createArtifactBloc: createArtifactBloc,
                    ),
                  );
            },
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

