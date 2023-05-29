import 'dart:async';

import 'blocs/bloc_drawer.dart';
import 'blocs/bloc_processing.dart';
import 'blocs/bloc_responsive.dart';
import 'blocs/bloc_secondary_drawer.dart';
import 'blocs/navigator_bloc.dart';
import 'blocs/onboarding_bloc.dart';
import 'blocs/theme_bloc.dart';
import 'entities/entity_bloc.dart';
import 'modules/demo/blocs/bloc_demo.dart';
import 'modules/demo/ui/pages/demo_home_page.dart';
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

    // Inyectamos el demo
    blocCoreInt.addBlocModule(
      BlocDemo.name,
      BlocDemo(
        drawerMainMenuBloc: blocCoreInt
            .getBlocModule<DrawerMainMenuBloc>(DrawerMainMenuBloc.name),
        drawerSecondaryMenuBloc:
            blocCoreInt.getBlocModule<DrawerSecondaryMenuBloc>(
          DrawerSecondaryMenuBloc.name,
        ),
      ),
    );
    blocCoreInt.addBlocModule(
      OnboardingBloc.name,
      OnboardingBloc(
        <FutureOr<void> Function()>[
          testMe,
          testMe,
          testMe,
          () async {
            await demoInsert(blocCoreInt);
          }
        ],
      ),
    );
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
