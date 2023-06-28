import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/create_artifact_bloc.dart';
import '../../models/artifact_model.dart';
import '../widgets/button.dart';
import 'form_codes_page.dart';

class FormArtifact extends StatelessWidget {
  const FormArtifact({required this.createArtifactBloc, super.key});

  final CreateArtifactBloc createArtifactBloc;

  @override
  Widget build(BuildContext context) {
    createArtifactBloc.clearShowCaseModel();
    String image = '';
    return MyAppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            CustomAutoCompleteInputWidget(
              label: 'Title',
              onEditingValueFunction: (String val) {
                createArtifactBloc.title = val;
              },
              onEditingValidateFunction: (String val) {
                final String? messageError =
                    createArtifactBloc.validateForm('String', val, true);
                return messageError;
              },
            ),
            CustomAutoCompleteInputWidget(
              label: 'Width',
              onEditingValueFunction: (String val) {},
              onEditingValidateFunction: (String val) {
                final String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
              textInputType: TextInputType.number,
            ),
            CustomAutoCompleteInputWidget(
              label: 'Height',
              onEditingValueFunction: (String val) {},
              onEditingValidateFunction: (String val) {
                final String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
              textInputType: TextInputType.number,
            ),
            CustomAutoCompleteInputWidget(
              label: 'Radius',
              onEditingValueFunction: (String val) {},
              onEditingValidateFunction: (String val) {
                final String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
              textInputType: TextInputType.number,
            ),
            CustomAutoCompleteInputWidget(
              label: 'Image',
              onEditingValueFunction: (String val) {
                image = val;
              },
              onEditingValidateFunction: (String val) {
                final String? messageError =
                    createArtifactBloc.validateForm('number', val, true);
                return messageError;
              },
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Button(
              title: 'Siguiente',
              onPressed: () {
                final ArtifactModel artifactModel = ArtifactModel(
                  type: createArtifactBloc.title,
                  image: image,
                  anatomyImage: '',
                  description: '',
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
