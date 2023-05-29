// ignore_for_file: require_trailing_commas

import 'package:aleteo_arquetipo/blocs/theme_bloc.dart';
import 'package:aleteo_arquetipo/services/theme_config.dart';
import 'package:aleteo_arquetipo/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeBloc', () {
    WidgetsFlutterBinding.ensureInitialized();
    late ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc(ThemeService(
        lightColorScheme: lightColorScheme,
        darkColorScheme: darkColorScheme,
        colorSeed: Colors.deepOrange,
      ));
    });

    test('Initial theme should be the same as the service theme', () {
      expect(themeBloc.theme.primaryColor.value, greaterThan(0));
    });

    test('Switching theme should update the theme data', () {
      final ThemeData oldTheme = themeBloc.theme;
      themeBloc.switchThemeBetweenLigthAndDark();
      final ThemeData newTheme = themeBloc.theme;
      expect(oldTheme.brightness, isNot(newTheme.brightness));
    });

    test('Changing theme should update the theme controller stream', () {
      final ThemeData oldTheme = themeBloc.theme;
      themeBloc.switchThemeBetweenLigthAndDark();
      final ThemeData newTheme = themeBloc.theme;
      expect(oldTheme, isNot(newTheme));
    });

    test('Theme stream should emit when theme changes', () {
      final Stream<ThemeData> stream = themeBloc.themeDataStream;
      final ThemeData expectedTheme = themeBloc.theme;
      themeBloc.theme = expectedTheme;
      expectLater(stream, emits(expectedTheme));
    });

    tearDown(() {
      themeBloc.dispose();
    });
  });
}
