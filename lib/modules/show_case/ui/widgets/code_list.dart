import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../blocs/show_case_bloc.dart';
import '../../models/code_artifact_model.dart';

class CodeList extends StatelessWidget {
  const CodeList({super.key, required this.codes, required this.showCaseBloc});
  final List<CodeArtifactModel> codes;
  final ShowCaseBloc showCaseBloc;

  @override
  Widget build(BuildContext context) {
    showCaseBloc.switchActiveLanguage(codes.first.language);
    showCaseBloc.switchActiveCode(codes.first.code);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: StreamBuilder(
          stream: showCaseBloc.activeLanguageStream,
          builder: (BuildContext context, AsyncSnapshot data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: codes.length,
                    itemBuilder: (context, index) {
                      final codeKey = codes[index].language;
                      final code = codes[index].code;
                      return InkWell(
                        autofocus: true,
                        onTap: () {
                          showCaseBloc.switchActiveLanguage(codeKey);
                          showCaseBloc.switchActiveCode(code);
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: showCaseBloc.activeLanguage == codeKey
                                ? const Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 2))
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              codeKey != ''
                                  ? codeKey[0].toUpperCase() +
                                      codeKey.substring(1)
                                  : '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                SelectableText(
                  showCaseBloc.activeCode,
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      Clipboard.setData(
                        ClipboardData(
                          text: showCaseBloc.activeCode,
                        ),
                      ).then(
                        (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Copied to clipboard !'),
                            ),
                          );
                        },
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.copy,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Copiar código',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
