import 'package:aleteo_arquetipo/modules/data_base/bloc/blocs.dart';
import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../blocs/navigator_bloc.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';
import '../widgets/button.dart';
import 'template_show_case_page.dart';

class ShowCaseHomePage extends StatefulWidget {
  const ShowCaseHomePage({super.key, required this.buttonBloc});
  final ShowCaseBloc buttonBloc;

  @override
  State<ShowCaseHomePage> createState() => _ShowCaseHomePageState();
}

class _ShowCaseHomePageState extends State<ShowCaseHomePage> {
  @override
  void initState() {
    final dataBaseBloc =
        blocCore.getBlocModule<DataBaseBloc>(DataBaseBloc.name);
    dataBaseBloc.read(module: "getShowCaseTest2", parameters: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      withAppbar: true,
      child: Center(
        child: Button(
          title: 'Boton de prueba',
          width: 150,
          height: 40,
          type: 'primary',
          onPressed: () {
            final result = widget.buttonBloc.getButtonShowCase();
            blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name).pushPage(
                  'Template Show Case',
                  TemplateShowCase(showCaseModel: result),
                );
          },
        ),
      ),
    );
  }
}
