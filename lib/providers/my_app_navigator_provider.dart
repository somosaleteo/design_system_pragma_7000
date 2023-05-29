import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppRouterDelegate extends RouterDelegate<PageManager>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageManager> {
  MyAppRouterDelegate() {
    myPageManager.addListener(notifyListeners);
  }
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  PageManager? get currentConfiguration => myPageManager.currentConfiguration;

  PageManager get pageManagerForTesting => myPageManager;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: myPageManager.pages,
      onPopPage: myPageManager.didPop,
    );
    // return const _MyNavigator();
  }

  @override
  Future<void> setNewRoutePath(PageManager configuration) async {
    configuration.update();
  }

  @override
  Future<bool> popRoute() {
    //print('Atras desde el dispositivo');
    myPageManager.back();
    return Future<bool>.value(true);
  }
}

class MyAppRouteInformationParser extends RouteInformationParser<PageManager> {
  @override
  Future<PageManager> parseRouteInformation(RouteInformation routeInformation) {
    return Future<PageManager>.value(
      PageManager.fromRouteInformation(routeInformation, myPageManager),
    );
  }

  @override
  RouteInformation? restoreRouteInformation(PageManager configuration) {
    return configuration.getCurrentUrl();
  }
}

const String _k404Name = '/404';

class PageManager extends ChangeNotifier {
  PageManager([this.routeInformation]) {
    setHomePage(onBoardingPage);
    set404Page(page404Widget);
  }

  PageManager.fromRouteInformation(
    this.routeInformation,
    PageManager currentPageManager,
  ) {
    setHomePage(currentPageManager.onBoardingPage);
    set404Page(currentPageManager.page404Widget);
    _pages.clear();
    _pages.addAll(currentPageManager.getAllPages);
    if (routeInformation != null) {
      final Uri uri = Uri.parse(routeInformation?.location ?? '');
      final MaterialPage<dynamic> page = currentPageManager
          .getPageFromDirectory(uri.path, arguments: uri.queryParametersAll);
      currentPageManager.push('/', onBoardingPage);
      currentPageManager.pushFromRoutesettings(uri.path, page);
    }
  }
  // Este page manager deberia ser unico en la aplicacion ???
  Widget page404Widget = const Page404Widget();
  Widget onBoardingPage = const OnBoardingPage();

  void update() {
    notifyListeners();
  }

  void removePageFromRoute(String route) {
    _removePageFromRoute(route);
    notifyListeners();
  }

  void _removePageFromRoute(String route) {
    if (route == '/') {
      return;
    }
    final List<MaterialPage<dynamic>> tmpPages = <MaterialPage<dynamic>>[];
    for (final MaterialPage<dynamic> tmp in _pages) {
      if (tmp.name != route) {
        tmpPages.add(tmp);
      }
    }
    _pages.clear();
    _pages.addAll(tmpPages);
  }

  void setPageTitle(String title, [int? color]) {
    if (kIsWeb) {
      title = title.replaceAll('/', ' ').trim();
      try {
        SystemChrome.setApplicationSwitcherDescription(
          ApplicationSwitcherDescription(
            label: title,
            primaryColor: color, // This line is required
          ),
        );
      } catch (e) {
        debugPrint('$e');
      }
    }
  }

  final StreamController<int> pageController = StreamController<int>.broadcast()
    ..add(1);

  Stream<int> get pagesStream => pageController.stream;

  final Map<String, MaterialPage<dynamic>> _directoryPagesMap =
      <String, MaterialPage<dynamic>>{};

  List<String> get directoryOfPages => _directoryPagesMap.keys.toList();

  void registerPageToDirectory({
    required String routeName,
    required Widget widget,
    Object? arguments,
  }) {
    routeName = validateRouteName(routeName);
    _directoryPagesMap[routeName] = MaterialPage<dynamic>(
      name: routeName,
      child: widget,
      arguments: arguments,
    );
  }

  void removePageFromDirectory(String routeName) {
    _directoryPagesMap.remove(routeName);
    notifyListeners();
  }

  void _cleanDuplicateHomePages() {
    if (_pages.length > 1) {
      final List<MaterialPage<dynamic>> tmpPages = <MaterialPage<dynamic>>[
        _pages[0]
      ];
      for (int i = 1; i < _pages.length; i++) {
        final MaterialPage<dynamic> value = _pages[i];
        if (value.name != '/') {
          tmpPages.add(value);
        }
      }
      _pages.clear();
      _pages.addAll(tmpPages);
    }
  }

  void setHomePage(Widget widget, [Object? arguments]) {
    /// This acts like the base of the navigator the main idea is first set the starting functions,
    _directoryPagesMap['/'] = MaterialPage<dynamic>(
      name: '/',
      key: UniqueKey(),
      child: widget,
      arguments: arguments,
    );
    _pages[0] = _directoryPagesMap['/']!;
    _cleanDuplicateHomePages();
    onBoardingPage = widget;
  }

  void set404Page(Widget widget, [Object? arguments]) {
    _directoryPagesMap[_k404Name] = MaterialPage<dynamic>(
      name: _k404Name,
      key: UniqueKey(),
      child: widget,
      arguments: arguments,
    );
    page404Widget = widget;
  }

  final List<MaterialPage<dynamic>> _pages = <MaterialPage<dynamic>>[
    MaterialPage<dynamic>(
      name: '/',
      key: UniqueKey(),
      child: const OnBoardingPage(),
    ),
  ];
  List<MaterialPage<dynamic>> get history => _pages;

  PageManager get currentConfiguration => this;

  bool isThisRouteNameInDirectory(String routeName) {
    return _directoryPagesMap.containsKey(validateRouteName(routeName));
  }

  String validateRouteName(String routeName) {
    if (routeName.isEmpty || routeName[0] != '/') {
      routeName = '/$routeName';
    }
    return routeName;
  }

  void push(String routeName, Widget widget, [Object? arguments]) {
    routeName = validateRouteName(routeName);
    final MaterialPage<dynamic> page = MaterialPage<dynamic>(
      name: routeName,
      key: ValueKey<String>(routeName),
      child: widget,
      arguments: arguments,
    );
    _directoryPagesMap[routeName] = page;
    _pages.remove(page);
    _pages.add(page);
    pageController.sink.add(_pages.length);
    notifyListeners();
  }

  void pushAndReplacement(
    String routeName,
    Widget widget, [
    Object? arguments,
  ]) {
    back();
    push(routeName, widget, arguments);
  }

  void pushNamed(String routeName, [Object? arguments]) {
    final Widget widget = getPageFromDirectory(routeName).child;
    push(routeName, widget, arguments);
  }

  void pushNamedAndReplacement(String routeName, [Object? arguments]) {
    back();
    final Widget widget = getPageFromDirectory(routeName).child;
    push(routeName, widget, arguments);
  }

  void pushFromRoutesettings(
    String routeName,
    MaterialPage<dynamic> routeSettings,
  ) {
    if (validateRouteName(routeName).length > 1) {
      _pages.remove(routeSettings);
      _pages.add(routeSettings);
      pageController.sink.add(_pages.length);
      notifyListeners();
    }
  }

  int get historyPagesCount => _pages.length;

  RouteSettings get currentPage => _pages.last;

  List<Page<dynamic>> get pages =>
      <Page<dynamic>>[List<Page<dynamic>>.unmodifiable(_pages).last];
  final RouteInformation? routeInformation;

  bool get isHome => true;

  List<MaterialPage<dynamic>> get getAllPages =>
      List<MaterialPage<dynamic>>.unmodifiable(_pages);
  void pop() {
    back();
  }

  void back() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
    }
  }

  bool didPop(Route<dynamic> route, dynamic result) {
    back();
    return true;
  }

  @override
  void dispose() {
    _pages.clear();
    pageController.close();
    super.dispose();
  }

  MaterialPage<dynamic> getPageFromDirectory(
    String routeName, {
    Object? arguments,
  }) {
    MaterialPage<dynamic> page = get404PageFromDirectory(arguments);
    if (isThisRouteNameInDirectory(routeName)) {
      page = _directoryPagesMap[routeName]!;
      page = MaterialPage<dynamic>(
        name: routeName,
        key: page.key,
        arguments: arguments,
        child: page.child,
      );
    }
    return page;
  }

  MaterialPage<dynamic> get404PageFromDirectory([Object? arguments]) {
    if (!_directoryPagesMap.containsKey(_k404Name)) {
      set404Page(const Page404Widget(), arguments);
    }
    MaterialPage<dynamic> page = _directoryPagesMap[_k404Name]!;
    page = MaterialPage<dynamic>(
      child: page.child,
      arguments: arguments,
      key: page.key,
      name: page.name,
    );
    return page;
  }

  void goTo404Page([Object? arguments]) {
    pushFromRoutesettings(_k404Name, get404PageFromDirectory(arguments));
  }

  RouteInformation? getCurrentUrl() {
    final Uri uri = Uri(
      path: currentPage.name,
      queryParameters: currentPage.arguments as Map<String, dynamic>?,
    );
    String location = uri.path;
    if (uri.query.isNotEmpty) {
      location = '$location?${uri.query}';
    }
    return RouteInformation(
      location: location,
    );
  }

  void clearHistory() {
    final MaterialPage<dynamic> tmp = _pages[0];
    _pages.clear();
    _pages.add(tmp);
    notifyListeners();
  }
}

final PageManager myPageManager = PageManager();

void debugPrint(dynamic msg) {
  if (kDebugMode) {
    print(msg);
  }
}

class Page404Widget extends StatelessWidget {
  const Page404Widget({super.key, this.currentPageManager});

  final PageManager? currentPageManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error 404'),
        leading: myPageManager.historyPagesCount > 1
            ? BackButton(
                onPressed: myPageManager.back,
              )
            : null,
      ),
      body: Center(
        child:
            Text('Pagina No encontrada ${myPageManager.currentPage.arguments}'),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, this.currentPageManager});
  final PageManager? currentPageManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome page'),
        leading: myPageManager.historyPagesCount > 1
            ? BackButton(
                onPressed: myPageManager.back,
              )
            : null,
      ),
      body: const Center(
        child: Text('Welcome Page'),
      ),
    );
  }
}
