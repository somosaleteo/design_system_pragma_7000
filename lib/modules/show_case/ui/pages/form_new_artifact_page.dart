import 'package:aleteo_arquetipo/ui/widgets/forms/custom_autocomplete_input_widget.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';

class FormNewArtifactPage extends StatefulWidget {
  const FormNewArtifactPage({super.key});

  @override
  State<FormNewArtifactPage> createState() => _FormNewArtifactPageState();
}

class _FormNewArtifactPageState extends State<FormNewArtifactPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      child: Center(
        child: Column(
          children: [
            Stepper(
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                    print('Entro a onStepCancel $_index');
                  });
                }
              },
              onStepContinue: () {
                if (_index <= 1) {
                  setState(() {
                    _index += 1;
                    print('Entro a onStepContinue $_index');
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                  print('Entro a onStepTapped $_index');
                });
              },
              steps: <Step>[
                Step(
                  title: const Text('Artifact'),
                  content: Column(
                    children: [
                      CustomAutoCompleteInputWidget(
                        label: 'Width',
                        onEditingValueFunction: (val) {},
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Height',
                        onEditingValueFunction: (val) {},
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Radius',
                        onEditingValueFunction: (val) {},
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Image',
                        onEditingValueFunction: (val) {},
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Code Artifact'),
                  content: Column(
                    children: [
                      CustomAutoCompleteInputWidget(
                        label: 'Language',
                        onEditingValueFunction: (val) {
                          // print('Language: $val');
                        },
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Code',
                        onEditingValueFunction: (val) {
                          // print('Code: $val');
                        },
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Instruction',
                        onEditingValueFunction: (val) {
                          // print('Instruction: $val');
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Properties Artifact'),
                  content: Column(
                    children: [
                      CustomAutoCompleteInputWidget(
                        label: 'Name',
                        onEditingValueFunction: (val) {},
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Description',
                        onEditingValueFunction: (val) {},
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Default Value',
                        onEditingValueFunction: (val) {},
                      ),
                      CustomAutoCompleteInputWidget(
                        label: 'Language',
                        onEditingValueFunction: (val) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Button(
              title: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
