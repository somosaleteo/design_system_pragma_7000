import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/create_artifact_bloc.dart';
import '../../models/code_artifact_model.dart';
import '../widgets/button.dart';
import 'form_properties_page.dart';

class FormCodeArtifact extends StatelessWidget {
  const FormCodeArtifact({required this.createArtifactBloc, super.key});
  final CreateArtifactBloc createArtifactBloc;
  @override
  Widget build(BuildContext context) {
    String language = '';
    String code = '';
    String instructions = '';
    bool existsLanguage = false;
    return MyAppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomAutoCompleteInputWidget(
                controller: createArtifactBloc.languageController,
                label: 'Language',
                onEditingValueFunction: (String val) {
                  language = val;
                },
                onEditingValidateFunction: (String val) {
                  final String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              CustomAutoCompleteInputWidget(
                controller: createArtifactBloc.codeController,
                label: 'Code',
                onEditingValueFunction: (String val) {
                  code = val;
                },
                onEditingValidateFunction: (String val) {
                  final String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              CustomAutoCompleteInputWidget(
                controller: createArtifactBloc.intructionController,
                label: 'Instruction',
                onEditingValueFunction: (String val) {
                  instructions = val;
                },
                onEditingValidateFunction: (String val) {
                  final String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              Button(
                title: 'Agregar',
                onPressed: () {
                  existsLanguage = createArtifactBloc.existsLanguage(language);

                  if (!existsLanguage) {
                    final CodeArtifactModel codeArtifactModel =
                        CodeArtifactModel(
                      type: createArtifactBloc.title,
                      language: language,
                      code: code,
                      instructions: instructions,
                      variant: '',
                    );
                    createArtifactBloc.addCode(codeArtifactModel);
                    createArtifactBloc.clearInputsCodeForm();
                  }
                },
              ),
              StreamBuilder<String>(
                stream: createArtifactBloc.languageExistsStream,
                builder: (BuildContext context, AsyncSnapshot<dynamic> data) {
                  return Text(createArtifactBloc.languageExists);
                },
              ),
              const Divider(),
              const Text('Códigos agregados'),
              StreamBuilder<List<CodeArtifactModel>>(
                stream: createArtifactBloc.listCodeArtifactModelStream,
                builder: (BuildContext context, AsyncSnapshot<dynamic> data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: createArtifactBloc.listCodeArtifactModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          createArtifactBloc
                              .listCodeArtifactModel[index].language,
                        ),
                      );
                    },
                  );
                },
              ),
              Button(
                title: 'Siguiente',
                onPressed: () {
                  blocCore
                      .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                      .pushPageWidthTitle(
                        'Properties by Artifact',
                        'formCodes',
                        FormPropertiesArtifact(
                          createArtifactBloc: createArtifactBloc,
                        ),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
