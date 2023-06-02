import 'package:flutter/material.dart';
import '../../abstractions/code_artifact.dart';

class CodeList extends StatelessWidget {
  const CodeList({super.key, required this.codes});
  final List<CodeArtifact> codes;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 200,
        color: Colors.black87,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: codes.length,
          itemBuilder: (context, index) {
            final codeKey = codes[index].language;
            final code = codes[index].code;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                    code,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Divider(
                    color: Colors.white,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
