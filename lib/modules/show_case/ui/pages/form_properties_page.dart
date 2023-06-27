import 'package:flutter/material.dart';

import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/create_artifact_bloc.dart';
import '../../models/code_artifact_model.dart';
import '../../models/properties_artifact_model.dart';
import '../widgets/button.dart';

class FormPropertiesArtifact extends StatelessWidget {
  const FormPropertiesArtifact({required this.createArtifactBloc, super.key});
  final CreateArtifactBloc createArtifactBloc;
  @override
  Widget build(BuildContext context) {
    String language = '';
    String name = '';
    String description = '';
    String defaultValue = '';
    return MyAppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField(
                items: createArtifactBloc.listCodeArtifactModel.map((CodeArtifactModel e) {
                  /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                  return DropdownMenuItem(
                    value: e.language,
                    child: Text(e.language),
                  );
                }).toList(),
                onChanged: (String? value) => language = value ?? '',
              ),
              CustomAutoCompleteInputWidget(
                label: 'Name',
                onEditingValueFunction: (String val) {
                  name = val;
                },
                onEditingValidateFunction: (String val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              CustomAutoCompleteInputWidget(
                label: 'Description',
                onEditingValueFunction: (String val) {
                   description = val;
                },
                onEditingValidateFunction: (String val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              CustomAutoCompleteInputWidget(
                label: 'Default Value',
                onEditingValueFunction: (String val) {
                   defaultValue = val;
                },
                onEditingValidateFunction: (String val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              Button(
                title: 'Agregar',
                onPressed: () {
                  final PropertiesArtifactModel propertiesArtifactModel =
                      PropertiesArtifactModel(
                    type: createArtifactBloc.title,
                    name: name,
                    defaultValue: defaultValue,
                    description: description,
                    language: language,
                  );
                  
                  createArtifactBloc.addProperties(propertiesArtifactModel);
                },
              ),
              
              const Divider(),
              const Text('Propiedades agregadas'),
              StreamBuilder(
                  stream: createArtifactBloc.listPropertiesArtifactModelStream,
                  builder: (BuildContext context, AsyncSnapshot data) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          createArtifactBloc.listPropertiesArtifactModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        final PropertiesArtifactModel property =
                            createArtifactBloc.listPropertiesArtifactModel[index];
                        return ListTile(
                          title: Text('${property.language} : ${property.name}'),
                        );
                      },
                    );
                  },),
              Button(
                title: 'Guardar',
                onPressed: () {
                  createArtifactBloc.saveArtifact();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
