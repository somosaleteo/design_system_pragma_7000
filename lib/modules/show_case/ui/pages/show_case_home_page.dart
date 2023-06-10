import 'package:aleteo_arquetipo/modules/show_case/blocs/create_artifact_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/pages/form_artifact_page.dart';
import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';
import '../widgets/button.dart';
import 'template_show_case_page.dart';

class ShowCaseHomePage extends StatelessWidget {
  const ShowCaseHomePage({super.key, required this.showCaseBloc, required this.createArtifactBloc});

  final ShowCaseBloc showCaseBloc;
  final CreateArtifactBloc createArtifactBloc;
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
                        blocCore
                            .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                            .pushPageWidthTitle(
                              showCase.title,
                              'template_show_case',
                              TemplateShowCase(
                                showCaseBloc: showCaseBloc,
                                showCaseModel:
                                    showCaseBloc.listShowCaseModel[index],
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
              onPressed: (){
                blocCore
                  .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                  .pushPageWidthTitle(
                    'Artifact',
                    'formArtifact',
                     FormArtifact(createArtifactBloc: createArtifactBloc,),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
