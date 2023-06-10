import 'package:aleteo_arquetipo/modules/show_case/models/properties_artifact_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/widgets/button.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import '../../blocs/create_artifact_bloc.dart';

class FormPropertiesArtifact extends StatelessWidget {
  const FormPropertiesArtifact({super.key, required this.createArtifactBloc});
  final CreateArtifactBloc createArtifactBloc;
  @override
  Widget build(BuildContext context) {
    String language = '';
    String name = '';
    String description = '';
    String defaultValue = '';
    return MyAppScaffold(
      withAppbar: true,
      withMargin: true,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField(
                items: createArtifactBloc.listCodeArtifactModel.map((e) {
                  /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                  return DropdownMenuItem(
                    value: e.language,
                    child: Text(e.language),
                  );
                }).toList(),
                onChanged: (value) => language = value ?? '',
              ),
              CustomAutoCompleteInputWidget(
                label: 'Name',
                onEditingValueFunction: (val) {
                  name = val;
                },
                onEditingValidateFunction: (val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
                textInputType: TextInputType.text,
              ),
              CustomAutoCompleteInputWidget(
                label: 'Description',
                onEditingValueFunction: (val) {
                   description = val;
                },
                textInputType: TextInputType.text,
                onEditingValidateFunction: (val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              CustomAutoCompleteInputWidget(
                label: 'Default Value',
                onEditingValueFunction: (val) {
                   defaultValue = val;
                },
                textInputType: TextInputType.text,
                onEditingValidateFunction: (val) {
                  String? messageError =
                      createArtifactBloc.validateForm('string', val, true);
                  return messageError;
                },
              ),
              Button(
                title: 'Agregar',
                onPressed: () {
                  PropertiesArtifactModel propertiesArtifactModel =
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
                        final property =
                            createArtifactBloc.listPropertiesArtifactModel[index];
                        return ListTile(
                          title: Text('${property.language} : ${property.name}'),
                        );
                      },
                    );
                  }),
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
