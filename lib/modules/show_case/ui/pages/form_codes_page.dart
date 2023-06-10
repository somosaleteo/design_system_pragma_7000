import 'package:aleteo_arquetipo/modules/show_case/models/code_artifact_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/pages/form_properties_page.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/widgets/button.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import '../../blocs/create_artifact_bloc.dart';

class FormCodeArtifact extends StatelessWidget {
  const FormCodeArtifact({super.key, required this.createArtifactBloc});
  final CreateArtifactBloc createArtifactBloc;
  @override
  Widget build(BuildContext context) {
    String language = '';
    String code = '';
    String instructions = '';
    bool existsLanguage = false;
    return MyAppScaffold(
      withAppbar: true,
      withMargin: true,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAutoCompleteInputWidget(
                controller: createArtifactBloc.languageController,
                label: 'Language',
                onEditingValueFunction: (val) {
                  language = val;
                },
                onEditingValidateFunction: (val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
                textInputType: TextInputType.text,
              ),
              CustomAutoCompleteInputWidget(
                controller: createArtifactBloc.codeController,
                label: 'Code',
                onEditingValueFunction: (val) {
                  code = val;
                },
                onEditingValidateFunction: (val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
                textInputType: TextInputType.text,
              ),
              CustomAutoCompleteInputWidget(
                controller: createArtifactBloc.intructionController,
                label: 'Instruction',
                onEditingValueFunction: (val) {
                  instructions = val;
                },
                onEditingValidateFunction: (val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
                textInputType: TextInputType.text,
              ),
              Button(
                title: 'Agregar',
                onPressed: () {
                  existsLanguage = createArtifactBloc.existsLanguage(language);
        
                  if (!existsLanguage) {
                    CodeArtifactModel codeArtifactModel = CodeArtifactModel(
                      type: createArtifactBloc.title,
                      language: language,
                      code: code,
                      instructions: instructions,
                    );
                    createArtifactBloc.addCode(codeArtifactModel);
                    createArtifactBloc.clearInputsCodeForm();
                  }
                },
              ),
              StreamBuilder(
                  stream: createArtifactBloc.languageExistsStream,
                  builder: (BuildContext context, AsyncSnapshot data) {
                    return Text(createArtifactBloc.languageExists);
                  }),
              const Divider(),
              const Text('Códigos agregados'),
              StreamBuilder(
                  stream: createArtifactBloc.listCodeArtifactModelStream,
                  builder: (BuildContext context, AsyncSnapshot data) {
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
                  }),
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
