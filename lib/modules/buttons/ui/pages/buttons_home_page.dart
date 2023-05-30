import 'package:aleteo_arquetipo/app_config.dart';
import 'package:aleteo_arquetipo/blocs/navigator_bloc.dart';
import 'package:aleteo_arquetipo/modules/buttons/blocs/button_bloc.dart';
import 'package:aleteo_arquetipo/modules/buttons/ui/pages/button_detail.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class ButtonsHomePage extends StatelessWidget {
  const ButtonsHomePage({super.key, required this.buttonBloc});

  final ButtonBloc buttonBloc;

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      withAppbar: true,
      child: Center(
        child: CustomButton(
          text: 'Button',
          onPressed: () {
            blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name).pushPage(
                  'Button Detail',
                  const ButtonDetail(),
                );
          },
        ),
      ),
    );
  }
}
