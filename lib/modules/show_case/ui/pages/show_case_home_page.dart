import 'package:aleteo_arquetipo/modules/show_case/blocs/create_artifact_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/blocs/template_show_case_model_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/pages/form_artifact_page.dart';
import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';
import '../widgets/button.dart';

class ShowCaseHomePage extends StatelessWidget {
  const ShowCaseHomePage(
      {super.key,
      required this.showCaseBloc,
      required this.createArtifactBloc,
      required this.templateShowCaseBloc,
      required this.navigatorBloc});

  final ShowCaseBloc showCaseBloc;
  final CreateArtifactBloc createArtifactBloc;
  final TemplateShowCaseBloc templateShowCaseBloc;
  final NavigatorBloc navigatorBloc;
  @override
  Widget build(BuildContext context) {
    showCaseBloc.getShowCaseData();
    return MyAppScaffold(
      withAppbar: true,
      child: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: showCaseBloc.listShowCaseModelStream,
              builder: (context, data) {
                if (showCaseBloc.listShowCaseModel.isEmpty) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: showCaseBloc.listShowCaseModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    final showCase = showCaseBloc.listShowCaseModel[index];
                    return ListTile(
                      onTap: () {
                        showCaseBloc.showCaseModelActive =
                            showCaseBloc.listShowCaseModel[index];
                        navigatorBloc.pushNamed(TemplateShowCaseBloc.name);
                      },
                      title: Text(showCase.artifact.type),
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
          ],
        ),
      ),
    );
  }
}
