import 'package:flutter/material.dart';
import '../../blocs/show_case_bloc.dart';
import '../../models/properties_artifact_model.dart';
import 'property.dart';

class PropertiesList extends StatelessWidget {
  const PropertiesList(
      {required this.properties, required this.showCaseBloc, super.key,});
  final List<PropertiesArtifactModel> properties;
  final ShowCaseBloc showCaseBloc;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: showCaseBloc.activeLanguageStream,
        builder: (BuildContext context, AsyncSnapshot<String> data) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: properties.length,
            itemBuilder: (BuildContext context, int index) {
              final PropertiesArtifactModel property = properties[index];
              return showCaseBloc.activeLanguage == property.language
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Property(text: property.name),
                            Property(text: property.description),
                            Property(text: property.defaultValue.toString()),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    )
                  : const SizedBox.shrink();
            },
          );
        },);
  }
}
