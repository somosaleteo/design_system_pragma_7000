import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  code ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      Clipboard.setData(ClipboardData(text: code)).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Copied to clipboard !')));
                      });
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Copy code',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
