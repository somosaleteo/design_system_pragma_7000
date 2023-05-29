import 'package:flutter/material.dart';

import 'app_config.dart';
import 'blocs/theme_bloc.dart';
import 'providers/my_app_navigator_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MyAppRouterDelegate routerDelegate = MyAppRouterDelegate();
    final MyAppRouteInformationParser routeInformationParser =
        MyAppRouteInformationParser();

    return StreamBuilder<ThemeData>(
      stream: blocCore.getBlocModule<ThemeBloc>(ThemeBloc.name).themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp.router(
          title: 'Arquetipo pragma',
          theme: snapshot.data,
          routerDelegate: routerDelegate,
          routeInformationParser: routeInformationParser,
        );
      },
    );
  }
}
