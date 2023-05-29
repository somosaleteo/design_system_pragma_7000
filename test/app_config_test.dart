import 'package:aleteo_arquetipo/app_config.dart';
import 'package:aleteo_arquetipo/blocs/bloc_drawer.dart';
import 'package:aleteo_arquetipo/blocs/bloc_processing.dart';
import 'package:aleteo_arquetipo/blocs/bloc_responsive.dart';
import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/blocs/navigator_bloc.dart';
import 'package:aleteo_arquetipo/blocs/onboarding_bloc.dart';
import 'package:aleteo_arquetipo/blocs/theme_bloc.dart';
import 'package:aleteo_arquetipo/entities/entity_bloc.dart';
import 'package:aleteo_arquetipo/modules/demo/blocs/bloc_demo.dart';
import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:aleteo_arquetipo/services/theme_config.dart';
import 'package:aleteo_arquetipo/services/theme_service.dart';
import 'package:aleteo_arquetipo/ui/pages/my_onboarding_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('testMe', () {
    test('waits for 2 seconds', () async {
      // Arrange
      final DateTime startTime = DateTime.now();

      // Act
      await testMe();

      // Assert
      final DateTime endTime = DateTime.now();
      final Duration difference = endTime.difference(startTime);
      expect(difference.inSeconds, greaterThanOrEqualTo(2));
    });
  });
  test('Test onboarding function', () async {
    final BlocCore<dynamic> blocCore = BlocCore<dynamic>();

    // Register modules
    final ResponsiveBloc responsiveBloc = ResponsiveBloc();
    blocCore.addBlocModule<ResponsiveBloc>(
      ResponsiveBloc.name,
      responsiveBloc,
    );

    blocCore.addBlocModule<BlocProcessing>(
      BlocProcessing.name,
      BlocProcessing(),
    );
    final DrawerMainMenuBloc drawerMainBloc = DrawerMainMenuBloc();

    blocCore.addBlocModule<DrawerMainMenuBloc>(
      DrawerMainMenuBloc.name,
      drawerMainBloc,
    );
    final DrawerSecondaryMenuBloc drawerSecondaryMenuBloc =
        DrawerSecondaryMenuBloc();
    blocCore.addBlocModule<DrawerSecondaryMenuBloc>(
      DrawerSecondaryMenuBloc.name,
      drawerSecondaryMenuBloc,
    );

    blocCore.addBlocModule<BlocDemo>(
      BlocDemo.name,
      BlocDemo(
        drawerMainMenuBloc: drawerMainBloc,
        drawerSecondaryMenuBloc: drawerSecondaryMenuBloc,
      ),
    );
    final OnboardingBloc onboardingBloc = OnboardingBloc(<void Function()>[]);
    blocCore.addBlocModule<OnboardingBloc>(OnboardingBloc.name, onboardingBloc);

    blocCore.addBlocModule<NavigatorBloc>(
      NavigatorBloc.name,
      NavigatorBloc(
        myPageManager,
        MyOnboardingPage(
          onboardingBloc: onboardingBloc,
          responsiveBloc: responsiveBloc,
        ),
      ),
    );

    blocCore.addBlocModule<ThemeBloc>(
      ThemeBloc.name,
      ThemeBloc(
        ThemeService(
          lightColorScheme: lightColorScheme,
          darkColorScheme: darkColorScheme,
          colorSeed: colorSeed,
        ),
      ),
    );
    await demoInsert(blocCore);
    // Call onboarding function
    await onboarding();

    // Assert that modules were registered correctly
    expect(
      blocCore.getBlocModule<ResponsiveBloc>(ResponsiveBloc.name),
      isNot(null),
    );
    expect(
      blocCore.getBlocModule<BlocProcessing>(BlocProcessing.name),
      isNot(null),
    );
    expect(
      blocCore.getBlocModule<DrawerMainMenuBloc>(DrawerMainMenuBloc.name),
      isNot(null),
    );
    expect(
      blocCore.getBlocModule<DrawerSecondaryMenuBloc>(
        DrawerSecondaryMenuBloc.name,
      ),
      isNot(null),
    );
    expect(blocCore.getBlocModule<BlocDemo>(BlocDemo.name), isNot(null));
    expect(
      blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name),
      isNot(null),
    );
    expect(blocCore.getBlocModule<ThemeBloc>(ThemeBloc.name), isNot(null));

    // Access specific modules and perform assertions
    expect(onboardingBloc, isNotNull);

    final NavigatorBloc navigatorBloc =
        blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name);
    expect(navigatorBloc, isNotNull);

    final ThemeBloc themeBloc =
        blocCore.getBlocModule<ThemeBloc>(ThemeBloc.name);
    expect(themeBloc, isNotNull);
    expect(isInit, true);
  });
}
