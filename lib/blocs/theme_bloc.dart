import 'dart:async';

import 'package:flutter/material.dart';

import '../entities/entity_bloc.dart';
import '../services/theme_service.dart';

class ThemeBloc extends BlocModule {
  ThemeBloc(ThemeService themeService) {
    _themeService = themeService;
    _themeController = BlocGeneral<ThemeData>(themeService.theme);
    _isThemeLight = true;
  }
  static String name = 'themeBloc';

  late BlocGeneral<ThemeData> _themeController;
  late ThemeService _themeService;
  late bool _isThemeLight;

  ThemeData get theme => _themeService.theme;
  bool get isThemeLight => _isThemeLight;

  set theme(ThemeData themeData) {
    _themeController.value = themeData;
  }

  set isThemeLight(bool value) {
    _isThemeLight = value;
  }

  Stream<ThemeData> get themeDataStream => _themeController.stream;

  void switchThemeBetweenLigthAndDark() {
    _themeService.switchLightAndDarkTheme();
    theme = _themeService.theme;
    isThemeLight = !_isThemeLight;
  }

  @override
  void dispose() {
    _themeController.close();
  }
}
