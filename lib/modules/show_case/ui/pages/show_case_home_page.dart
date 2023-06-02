import 'package:aleteo_arquetipo/modules/show_case/models/show_case_model.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/pages/template_show_case_page.dart';
import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';

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
                      return ListTile(
                        onTap: () {
                          blocCore
                              .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                              .pushPage(
                                'Template Show Case',
                                TemplateShowCase(
                                  showCaseModel: data.data![index],
                                ),
                              );
                        },
                        title: Text(
                          data.data![index].title,
                        ),
                      );
                    })
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
