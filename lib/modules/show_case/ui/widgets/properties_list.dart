import 'package:flutter/material.dart';
import '../../models/show_case_model.dart';
import 'property.dart';

class PropertiesList extends StatelessWidget {
  const PropertiesList({super.key, required this.showCaseModel});
  final ShowCaseModel showCaseModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: showCaseModel.propertiesArtifact.length,
      itemBuilder: (context, index) {
        final property = showCaseModel.propertiesArtifact[index];
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Property(text: property.name),
                Property(text: property.description),
                Property(text: property.defaultValue),
              ],
            ),
            const Divider(color: Colors.grey),
          ],
        );
      },
    );
  }
}
