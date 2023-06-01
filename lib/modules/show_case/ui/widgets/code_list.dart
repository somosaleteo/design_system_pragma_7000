import 'package:flutter/material.dart';
import '../../models/show_case_model.dart';

class CodeList extends StatelessWidget {
  const CodeList({super.key, required this.showCaseModel});
  final ShowCaseModel showCaseModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: showCaseModel.codeArtifact.codes.length,
        itemBuilder: (context, index) {
          final codeKey =
              showCaseModel.codeArtifact.codes.keys.elementAt(index);
          final code = showCaseModel.codeArtifact.codes[codeKey];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lenguaje: $codeKey',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                code ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
