import 'package:aleteo_arquetipo/blocs/navigator_bloc.dart';
import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:flutter/material.dart';

class MockNavigatorBloc extends NavigatorBloc {
  MockNavigatorBloc(PageManager pageManager, [Widget? homePage])
      : super(pageManager) {
    _pageManager = pageManager;
    _title = '';
    if (homePage != null) {
      setHomePage(homePage);
    }
  }
  late PageManager _pageManager;
  late String _title;

  @override
  String get title => _title;

  @override
  int get historyPageLength => _pageManager.historyPagesCount;

  @override
  void setTitle(String title) {
    _title = title;
    _pageManager.setPageTitle(title);
  }

  @override
  void update() {
    _pageManager.update();
  }

  @override
  void pushPage(String routeName, Widget widget, [Object? arguments]) {
    _pageManager.push(routeName, widget, arguments);
  }

  @override
  void pushAndReplacement(
    String routeName,
    Widget widget, [
    Object? arguments,
  ]) {
    _pageManager.pushAndReplacement(routeName, widget, arguments);
  }

  @override
  void pushNamedAndReplacement(String routeName, [Object? arguments]) {
    _pageManager.pushNamedAndReplacement(routeName, arguments);
  }

  @override
  void pushPageWidthTitle(String title, String routeName, Widget widget) {
    _pageManager.setPageTitle(title);
    _title = title;
    _pageManager.push(routeName, widget);
  }

  @override
  void setHomePage(Widget widget, [Object? arguments]) {
    _pageManager.setHomePage(widget, arguments);
  }

  @override
  void setHomePageAndUpdate(Widget widget, [Object? arguments]) {
    _pageManager.setHomePage(widget, arguments);
    update();
  }

  @override
  void addPagesForDynamicLinksDirectory(Map<String, Widget> mapOfPages) {
    mapOfPages.forEach((String key, Widget value) {
      _pageManager.registerPageToDirectory(routeName: key, widget: value);
      _pageManager.push(key, value);
    });
  }

  @override
  void removePageFromHistory(String routeName) {
    _pageManager.removePageFromDirectory(routeName);
  }

  @override
  void pushNamed(String routeName) {
    try {
      if (routeName[0] != '/') {
        routeName = '/$routeName';
      }
      _pageManager.pushNamed(routeName);
    } catch (e) {
      // TODO(aleteoAxioma): Handle the error
    }
  }

  @override
  List<String> get directoryOfRoutes => _pageManager.directoryOfPages;

  @override
  List<MaterialPage<dynamic>> get history => _pageManager.history;

  @override
  List<String> get historyPageNames {
    final List<String> listOfPages = <String>[];
    for (final MaterialPage<dynamic> element in history) {
      listOfPages.add(element.name ?? '');
    }
    return listOfPages;
  }

  @override
  void clearAndGoHome() {
    _pageManager.clearHistory();
  }
}
