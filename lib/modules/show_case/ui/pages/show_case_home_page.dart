import 'package:aleteo_arquetipo/app_config.dart';
import 'package:aleteo_arquetipo/blocs/navigator_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/blocs/show_case_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/pages/template_show_case_page.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class ShowCaseHomePage extends StatelessWidget {
  const ShowCaseHomePage({super.key, required this.buttonBloc});

  final ShowCaseBloc buttonBloc;

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      withAppbar: true,
      child: Center(
        child: CustomButton(
          text: 'Template',
          onPressed: () {
            blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name).pushPage(
                  'Template Show Case',
                  const TemplateShowCase(),
                );
          },
        ),
      ),
    );
  }
}
