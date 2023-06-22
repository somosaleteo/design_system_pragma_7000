import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/theme_bloc.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/create_artifact_bloc.dart';
import '../../blocs/show_case_bloc.dart';
import '../../blocs/template_show_case_model_bloc.dart';
import '../widgets/button.dart';
import 'form_artifact_page.dart';

class ShowCaseHomePage extends StatelessWidget {
  const ShowCaseHomePage({
    super.key,
    required this.showCaseBloc,
    required this.createArtifactBloc,
    required this.templateShowCaseBloc,
    required this.navigatorBloc,
    required this.themeBloc,
  });

  final ShowCaseBloc showCaseBloc;
  final CreateArtifactBloc createArtifactBloc;
  final TemplateShowCaseBloc templateShowCaseBloc;
  final NavigatorBloc navigatorBloc;
  final ThemeBloc themeBloc;
  @override
  Widget build(BuildContext context) {
    showCaseBloc.getShowCaseData();
    return MyAppScaffold(
      withAppbar: true,
      child: Column(
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
        ],
      ),
    );
  }
}
