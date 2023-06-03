import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';
import '../../models/show_case_model.dart';
import '../widgets/button.dart';
import '../widgets/checkbox_item.dart';
import 'template_show_case_page.dart';

class ShowCaseHomePage extends StatelessWidget {
  const ShowCaseHomePage({super.key, required this.showCaseBloc});

  final ShowCaseBloc showCaseBloc;
  @override
  Widget build(BuildContext context) {
    showCaseBloc.getShowCaseData();
    return MyAppScaffold(
      withAppbar: true,
      child: Center(
        child: StreamBuilder(
          stream: showCaseBloc.listShowCaseModelStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<ShowCaseModel>> data) {
            return data.data != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final showCase = data.data![index];
                      return Column(
                        children: [
                          if (showCase.artifact.type == 'button')
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Button(
                                onPressed: () {
                                  blocCore
                                      .getBlocModule<NavigatorBloc>(
                                          NavigatorBloc.name)
                                      .pushPage(
                                        'Template Show Case',
                                        TemplateShowCase(
                                          showCaseModel: data.data![index],
                                        ),
                                      );
                                },
                              ),
                            ),
                          if (showCase.artifact.type == 'checkbox')
                            CheckBoxItem(
                              onChanged: (value) {
                                value = true;
                                blocCore
                                    .getBlocModule<NavigatorBloc>(
                                        NavigatorBloc.name)
                                    .pushPage(
                                      'Template Show Case',
                                      TemplateShowCase(
                                        showCaseModel: data.data![index],
                                      ),
                                    );
                              },
                            ),
                        ],
                      );
                    },
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
