import 'dart:async';

import 'package:flutter/material.dart';

import '../entities/entity_bloc.dart';
import '../providers/my_app_navigator_provider.dart';

class NavigatorBloc extends BlocModule {
  NavigatorBloc(PageManager pageManager, [Widget? homePage]) {
    _pageManager = pageManager;
    if (homePage != null) {
      setHomePage(homePage);
    }
  }
  static String name = 'blocNavigator';
  late PageManager _pageManager;

  void back() {
    _pageManager.back();
  }

  String _title = '';
  String get title => _title;
  int get historyPageLength => _pageManager.historyPagesCount;

  void setTitle(String title) {
    _title = title;
    _pageManager.setPageTitle(title);
  }

  void update() {
    _pageManager.update();
  }

  void pushPage(String routeName, Widget widget, [Object? arguments]) {
    _pageManager.push(routeName, widget, arguments);
  }

  void pushAndReplacement(
    String routeName,
    Widget widget, [
    Object? arguments,
  ]) {
    _pageManager.pushAndReplacement(routeName, widget, arguments);
  }

  void pushNamedAndReplacement(String routeName, [Object? arguments]) {
    _pageManager.pushNamedAndReplacement(routeName, arguments);
  }

  void pushPageWidthTitle(String title, String routeName, Widget widget) {
    _pageManager.setPageTitle(title);
    _title = title;
    _pageManager.push(routeName, widget);
  }

  void setHomePage(Widget widget, [Object? arguments]) {
    _pageManager.setHomePage(widget, arguments);
  }

  void setHomePageAndUpdate(Widget widget, [Object? arguments]) {
    _pageManager.setHomePage(widget, arguments);
    update();
  }

  void addPagesForDynamicLinksDirectory(Map<String, Widget> mapOfPages) {
    mapOfPages.forEach((String key, Widget value) {
      _pageManager.registerPageToDirectory(routeName: key, widget: value);
    });
  }

  void removePageFromHistory(String routeName) {
    _pageManager.removePageFromDirectory(routeName);
  }

  void pushNamed(String routeName) {
    try {
      if (routeName[0] != '/') {
        routeName = '/$routeName';
      }
      myPageManager.pushNamed(routeName);
    } catch (e) {
      // TODO(aleteoAxioma): Revisar el servicio de crashalytics.
    }
  }

  List<String> get directoryOfRoutes => _pageManager.directoryOfPages;
  List<MaterialPage<dynamic>> get history => _pageManager.history;
  List<String> get historyPageNames {
    final List<String> listOfPages = <String>[];
    for (final MaterialPage<dynamic> element in history) {
      listOfPages.add(element.name ?? '');
    }
    return listOfPages;
  }

  void clearAndGoHome() {
    _pageManager.clearHistory();
  }

  @override
  FutureOr<void> dispose() {
    _pageManager.dispose();
    return null;
  }
}
