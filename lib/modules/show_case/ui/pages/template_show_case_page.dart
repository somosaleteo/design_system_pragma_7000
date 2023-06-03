import 'package:aleteo_arquetipo/modules/show_case/ui/widgets/button.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/widgets/checkbox_item.dart';
import 'package:flutter/material.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../models/show_case_model.dart';
import '../widgets/code_list.dart';
import '../widgets/properties_list.dart';
import '../widgets/propery_header.dart';

class TemplateShowCase extends StatelessWidget {
  const TemplateShowCase({
    super.key,
    required this.showCaseModel,
  });
  final ShowCaseModel showCaseModel;
  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text(showCaseModel.title, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10.0),
            if (showCaseModel.artifact.type == 'button')
              const Button(title: 'Adios mundo'),
            if (showCaseModel.artifact.type == 'checkbox')
              CheckBoxItem(onChanged: (value) {}),
            const SizedBox(height: 10.0),
            CodeList(codes: showCaseModel.codeArtifact),
            const SizedBox(height: 15.0),
            const PropertyHeader(),
            PropertiesList(properties: showCaseModel.propertiesArtifact),
          ],
        ),
      ),
    );
  }
}
