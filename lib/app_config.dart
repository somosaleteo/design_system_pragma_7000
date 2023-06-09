import 'dart:async';
import 'package:aleteo_arquetipo/modules/show_case/blocs/create_artifact_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/blocs/template_show_case_model_bloc.dart';
import 'package:aleteo_arquetipo/modules/show_case/ui/pages/template_show_case_page.dart';
import 'package:flutter/material.dart';

import 'blocs/bloc_drawer.dart';
import 'blocs/bloc_http.dart';
import 'blocs/bloc_processing.dart';
import 'blocs/bloc_responsive.dart';
import 'blocs/bloc_secondary_drawer.dart';
import 'blocs/navigator_bloc.dart';
import 'blocs/onboarding_bloc.dart';
import 'blocs/theme_bloc.dart';
import 'entities/entity_bloc.dart';
import 'modules/show_case/blocs/show_case_bloc.dart';
import 'modules/demo/blocs/bloc_demo.dart';
import 'modules/demo/ui/pages/demo_home_page.dart';
import 'modules/show_case/ui/pages/show_case_home_page.dart';
import 'providers/my_app_navigator_provider.dart';
import 'services/theme_config.dart';
import 'services/theme_service.dart';
import 'ui/pages/my_onboarding_page.dart';

bool _init = false;
bool get isInit => _init;

/// Zona de configuración inicial
final BlocCore<dynamic> blocCore = BlocCore<dynamic>(<String, BlocModule>{
  ResponsiveBloc.name: ResponsiveBloc(),
  BlocProcessing.name: BlocProcessing(),
  DrawerMainMenuBloc.name: DrawerMainMenuBloc(),
  DrawerSecondaryMenuBloc.name: DrawerSecondaryMenuBloc(),
  NavigatorBloc.name: NavigatorBloc(myPageManager)
});

FutureOr<void> testMe() async {
  await Future<void>.delayed(
    const Duration(seconds: 2),
  );
}

FutureOr<void> demoInsert(BlocCore<dynamic> blocCoreInt) async {
  blocCoreInt
      .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
      .setHomePageAndUpdate(
        DemoHomePage(
          blocDemo: blocCoreInt.getBlocModule<BlocDemo>(BlocDemo.name),
        ),
      );
  blocCoreInt
      .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
      .setTitle('Demo Home');
}

FutureOr<void> showCaseBlocInsert(BlocCore<dynamic> blocCoreInt) async {
  ShowCaseBloc showCaseBloc = blocCoreInt.getBlocModule<ShowCaseBloc>(ShowCaseBloc.name);
  TemplateShowCaseBloc templateShowCaseBloc = blocCoreInt.getBlocModule<TemplateShowCaseBloc>(TemplateShowCaseBloc.name);
  CreateArtifactBloc createArtifactBloc = blocCoreInt.getBlocModule<CreateArtifactBloc>(CreateArtifactBloc.name);
  NavigatorBloc navigatorBloc = blocCoreInt.getBlocModule<NavigatorBloc>(NavigatorBloc.name);
  ThemeBloc themeBloc = blocCoreInt.getBlocModule<ThemeBloc>(ThemeBloc.name);
  
  final ShowCaseHomePage showCaseHomePage = ShowCaseHomePage(
    navigatorBloc: navigatorBloc,
    createArtifactBloc: createArtifactBloc,
    showCaseBloc: showCaseBloc,
    templateShowCaseBloc: templateShowCaseBloc,
    themeBloc: themeBloc,
  );

  final TemplateShowCase templateShowCasePage = TemplateShowCase(
    showCaseBloc: showCaseBloc,
    templateShowCaseBloc: templateShowCaseBloc,
  );
  navigatorBloc.setHomePageAndUpdate(showCaseHomePage);
  navigatorBloc.setTitle('Show Case Home');
  Map<String, Widget> availablePages = {
    ShowCaseBloc.name: showCaseHomePage,
    TemplateShowCaseBloc.name: templateShowCasePage
  };

  navigatorBloc.addPagesForDynamicLinksDirectory(availablePages);
}

Future<void> onboarding({
  BlocCore<dynamic>? blocCoreExt,
  Duration initialDelay = const Duration(seconds: 2),
}) async {
  if (!_init) {
    final BlocCore<dynamic> blocCoreInt = blocCoreExt ?? blocCore;

    /// Register modules to use
    /// Inicializamos el responsive y la ux del usuario
    // inyectamos el tema
    blocCoreInt.addBlocModule(
      ThemeBloc.name,
      ThemeBloc(
        ThemeService(
          lightColorScheme: lightColorScheme,
          darkColorScheme: darkColorScheme,
          colorSeed: colorSeed,
        ),
      ),
    );
    blocCore.addBlocModule<BlocHttp>(
      BlocHttp.name,
      BlocHttp(
        navigatorBloc: blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name),
      ),
    );
    blocCoreInt.addBlocModule(
      ShowCaseBloc.name,
      ShowCaseBloc(
        blocHttp: blocCore.getBlocModule<BlocHttp>(BlocHttp.name),
        drawerMainMenuBloc: blocCoreInt.getBlocModule<DrawerMainMenuBloc>(DrawerMainMenuBloc.name),
        drawerSecondaryMenuBloc: blocCoreInt.getBlocModule<DrawerSecondaryMenuBloc>(DrawerSecondaryMenuBloc.name),
        navigatorBloc: blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name),
      ),
    );

    blocCoreInt.addBlocModule(
      TemplateShowCaseBloc.name,
      TemplateShowCaseBloc(),
    );
    blocCoreInt.addBlocModule(
      CreateArtifactBloc.name,
      CreateArtifactBloc(
        blocHttp: blocCore.getBlocModule<BlocHttp>(BlocHttp.name),
      ),
    );
    blocCoreInt.addBlocModule(
        OnboardingBloc.name,
        OnboardingBloc(
          <FutureOr<void> Function()>[
            testMe,
            () async {
              await showCaseBlocInsert(blocCoreInt);
            }
          ],
        ));
// redirigimos al onboarding
    blocCoreInt
        .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
        .setHomePageAndUpdate(
          MyOnboardingPage(
            onboardingBloc:
                blocCoreInt.getBlocModule<OnboardingBloc>(OnboardingBloc.name),
            responsiveBloc:
                blocCoreInt.getBlocModule<ResponsiveBloc>(ResponsiveBloc.name),
          ),
        );

    /// register onboarding
    _init = true;
  }
}