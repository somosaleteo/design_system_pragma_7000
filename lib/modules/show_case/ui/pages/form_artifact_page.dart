import 'package:aleteo_arquetipo/modules/show_case/blocs/create_artifact_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/models/artifact_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/widgets/button.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import 'form_codes_page.dart';

class FormArtifact extends StatelessWidget {
  const FormArtifact({super.key, required this.createArtifactBloc});

  final CreateArtifactBloc createArtifactBloc;

  @override
  Widget build(BuildContext context) {
    createArtifactBloc.clearShowCaseModel();
    int width = 0;
    int height = 0;
    int radius = 0;
    String image = '';
    return MyAppScaffold(
      withAppbar: true,
      withMargin: true,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            CustomAutoCompleteInputWidget(
              label: 'Title',
              onEditingValueFunction: (val) {
                createArtifactBloc.title = val;
              },
              onEditingValidateFunction: (val) {
                String? messageError =
                    createArtifactBloc.validateForm('String', val, true);
                return messageError;
              },
              textInputType: TextInputType.text,
            ),
            CustomAutoCompleteInputWidget(
              label: 'Width',
              onEditingValueFunction: (val) {
                width = int.parse(val);
              },
              onEditingValidateFunction: (val) {
                String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
              textInputType: TextInputType.number,
            ),
            CustomAutoCompleteInputWidget(
              label: 'Height',
              onEditingValueFunction: (val) {
                height = int.parse(val);
              },
              onEditingValidateFunction: (val) {
                String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
              textInputType: TextInputType.number,
            ),
            CustomAutoCompleteInputWidget(
              label: 'Radius',
              onEditingValueFunction: (val) {
                radius = int.parse(val);
              },
              onEditingValidateFunction: (val) {
                String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
              textInputType: TextInputType.number,
            ),
            CustomAutoCompleteInputWidget(
              label: 'Image',
              onEditingValueFunction: (val) {
                image = val;
              },
              onEditingValidateFunction: (val) {
                String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
              textInputType: TextInputType.text,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Button(
              title: 'Siguiente',
              onPressed: () {
                ArtifactModel artifactModel = ArtifactModel(
                  type: createArtifactBloc.title,
                  height: height,
                  radius: radius,
                  width: width,
                  image: image,
                );
                createArtifactBloc.artifactModel = artifactModel;
        
                blocCore
                    .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                    .pushPageWidthTitle(
                      'Codes by Artifact',
                      'formCodes',
                      FormCodeArtifact(
                        createArtifactBloc: createArtifactBloc,
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
