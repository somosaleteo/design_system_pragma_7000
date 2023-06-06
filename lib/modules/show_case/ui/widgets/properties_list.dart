import 'package:flutter/material.dart';
import '../../blocs/show_case_bloc.dart';
import '../../models/properties_artifact_model.dart';
import 'property.dart';

class PropertiesList extends StatelessWidget {
  const PropertiesList({super.key, required this.properties, required this.showCaseBloc});
  final List<PropertiesArtifactModel> properties;
  final ShowCaseBloc showCaseBloc;
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
        stream: showCaseBloc.activeLanguageStream,
        builder: (BuildContext context, AsyncSnapshot<String> data) {
          print('Stream');
          print(data.data);
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return showCaseBloc.activeLanguage == property.language ? Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Property(text: property.name),
                      Property(text: property.description),
                      Property(text: property.defaultValue.toString()),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                ],
              ) :
              const SizedBox.shrink();
            },
          );
        });
  }
}
