import 'package:flutter/material.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';
import '../../models/show_case_model.dart';
import '../widgets/code_list.dart';
import '../widgets/properties_list.dart';
import '../widgets/propery_header.dart';

class TemplateShowCase extends StatelessWidget {
  const TemplateShowCase({
    super.key,
    required this.showCaseModel,
    required this.showCaseBloc,
  });
  final ShowCaseModel showCaseModel;
  final ShowCaseBloc showCaseBloc;
  @override
  Widget build(BuildContext context) {
    final urlImageDrive = showCaseBloc.parseUrlValidFromDrive(showCaseModel.artifact.type);
    return MyAppScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text(showCaseModel.title, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10.0),
            
            Image.network(
                urlImageDrive ?? 'https://cdn-icons-png.flaticon.com/256/3342/3342137.png'),
            const SizedBox(height: 10.0),
            CodeList(
              codes: showCaseModel.codeArtifact,
              showCaseBloc: showCaseBloc,
            ),
            const SizedBox(height: 15.0),
            const PropertyHeader(),
            PropertiesList(
              properties: showCaseModel.propertiesArtifact,
              showCaseBloc: showCaseBloc,
            ),
          ],
        ),
      ),
    );
  }
}
