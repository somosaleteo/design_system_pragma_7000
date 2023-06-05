import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';
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
          builder: (context, data) {
            if (showCaseBloc.listShowCaseModel.isEmpty) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: showCaseBloc.listShowCaseModel.length,
              itemBuilder: (BuildContext context, int index) {
                final showCase = showCaseBloc.listShowCaseModel[index];
                return ListTile(
                  onTap: () {
                    blocCore
                        .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                        .pushPage(
                          'Template Show Case',
                          TemplateShowCase(
                            showCaseModel:
                                showCaseBloc.listShowCaseModel[index],
                          ),
                        );
                  },
                  title: Text(showCase.title),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
