import 'package:flutter/material.dart';
import '../../models/properties_artifact_model.dart';
import 'property.dart';

class PropertiesList extends StatelessWidget {
  const PropertiesList({super.key, required this.properties});
  final List<PropertiesArtifactModel> properties;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return Column(
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
        );
      },
    );
  }
}
