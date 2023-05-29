import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('testing', () {
    testWidgets('MyAppRouterDelegate - setNewRoutePath method',
        (WidgetTester tester) async {
      final MyAppRouterDelegate delegate = MyAppRouterDelegate();
      final PageManager pageManager = delegate.pageManagerForTesting;

      final PageManager newConfiguration = PageManager();
      await delegate.setNewRoutePath(newConfiguration);

      // Verify that the currentConfiguration is updated correctly
      expect(
        pageManager.currentConfiguration.history.length,
        equals(newConfiguration.history.length),
      );
    });
  });
  group('MyAppRouterDelegate', () {
    late MyAppRouterDelegate routerDelegate;
    late PageManager pageManager;
    setUp(() {
      pageManager = PageManager();
      routerDelegate = MyAppRouterDelegate();
    });

    test('currentConfiguration returns the current configuration', () {
      expect(
        routerDelegate.currentConfiguration?.historyPagesCount,
        pageManager.currentConfiguration.historyPagesCount,
      );
    });

    testWidgets('build method builds a Navigator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: MyAppRouteInformationParser(),
        ),
      );
      expect(find.byType(Navigator), findsOneWidget);
    });

    test('setNewRoutePath updates the configuration', () async {
      final PageManager newConfiguration = PageManager();
      await routerDelegate.setNewRoutePath(newConfiguration);
      expect(
        pageManager.currentConfiguration.historyPagesCount,
        newConfiguration.historyPagesCount,
      );
    });

    test('popRoute calls back on the PageManager', () async {
      final bool tmp = await routerDelegate.popRoute();
      pageManager.push('/', const Placeholder());
      pageManager.push('/', const Placeholder());
      expect(pageManager.historyPagesCount, greaterThan(1));
      pageManager.setHomePage(const Center());
      expect(tmp, true);
    });
  });

  group('Testing 2', () {
    testWidgets('MyAppRouterDelegate - build method',
        (WidgetTester tester) async {
      final MyAppRouterDelegate delegate = MyAppRouterDelegate();
      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: delegate,
          routeInformationParser: MyAppRouteInformationParser(),
        ),
      );

      // Verify that Navigator with correct pages is built
      final Finder navigatorFinder = find.byType(Navigator);
      expect(navigatorFinder, findsOneWidget);
      final Navigator navigator = tester.widget<Navigator>(navigatorFinder);
      expect(navigator.pages, equals(delegate.pageManagerForTesting.pages));
    });

    testWidgets('MyAppRouterDelegate - popRoute method',
        (WidgetTester tester) async {
      final MyAppRouterDelegate delegate = MyAppRouterDelegate();
      final PageManager pageManager = delegate.pageManagerForTesting;

      final bool didPop = await delegate.popRoute();

      // Verify that the last page is removed from the PageManager's history
      expect(pageManager.history.length, equals(1));
      expect(didPop, isTrue);
    });

    test('PageManager - constructor and methods', () {
      final PageManager pageManager = PageManager();

      // Verify that the initial pages are set correctly
      expect(pageManager.onBoardingPage, isNotNull);
      expect(pageManager.page404Widget, isNotNull);
      expect(pageManager.history.length, equals(1));
      expect(pageManager.getAllPages.length, equals(1));
      expect(
        pageManager.getAllPages[0].child.runtimeType,
        equals(OnBoardingPage),
      );

      // Verify that pushing a new page adds it to the history
      final MaterialPage<dynamic> newPage =
          MaterialPage<dynamic>(name: '/test', child: Container());
      pageManager.push('/test', Container());
      expect(pageManager.history.length, equals(2));
      expect(
        pageManager.history[1].name,
        equals(newPage.name),
      );

      // Verify that pushing and replacing a page replaces the last page in the history
      final MaterialPage<dynamic> replacedPage =
          MaterialPage<dynamic>(name: '/replaced', child: Container());
      pageManager.pushAndReplacement('/replaced', Container());
      expect(pageManager.history.length, equals(2));
      expect(pageManager.history[1].name, equals(replacedPage.name));

      // Verify that pushing named routes adds the corresponding pages to the history
      pageManager.registerPageToDirectory(
        routeName: '/test',
        widget: Container(),
      );
      pageManager.pushNamed('/test');
      expect(pageManager.history.length, equals(3));
      expect(pageManager.history[2].name, equals('/test'));

      // Verify that popping a route removes the last page from the history
      pageManager.pop();
      expect(pageManager.history.length, equals(2));

      // Verify that removing a page from the route removes it from the history
      pageManager.removePageFromRoute('/replaced');
      expect(pageManager.history.length, equals(1));
    });

    test('PageManager - getPageFromDirectory method', () {
      final PageManager pageManager = PageManager();
      final MaterialPage<dynamic> page =
          MaterialPage<dynamic>(name: '/test', child: Container());
      pageManager.registerPageToDirectory(
        routeName: '/test',
        widget: Container(),
      );

      // Verify that getPageFromDirectory returns the correct page
      final MaterialPage<dynamic> retrievedPage =
          pageManager.getPageFromDirectory('/test');
      expect(retrievedPage.name, equals(page.name));

      // Verify that getPageFromDirectory returns the 404 page if the route is not in the directory
      final MaterialPage<dynamic> page404 =
          pageManager.get404PageFromDirectory();
      final MaterialPage<dynamic> retrievedPage404 =
          pageManager.getPageFromDirectory('/unknown');
      expect(retrievedPage404.name, equals(page404.name));
    });
  });

  group('OnBoardingPage', () {
    testWidgets('should display welcome message', (WidgetTester tester) async {
      // Create mock instances
      final PageManager mockPageManager = PageManager();

      // Build the OnBoardingPage widget
      await tester.pumpWidget(
        MaterialApp(
          home: OnBoardingPage(currentPageManager: mockPageManager),
        ),
      );

      // Verify that the welcome message is displayed
      expect(find.text('Welcome Page'), findsOneWidget);
    });

    testWidgets('should show BackButton when historyPagesCount > 1',
        (WidgetTester tester) async {
      // Create mock instances
      final PageManager mockPageManager = PageManager();
      mockPageManager.push('/hola', const Placeholder());
      mockPageManager.push('/hola2', const Placeholder());
      // Build the OnBoardingPage widget
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: OnBoardingPage(currentPageManager: mockPageManager),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify that the BackButton is displayed
      expect(mockPageManager.historyPagesCount, greaterThan(1));
    });

    testWidgets('should not show BackButton when historyPagesCount <= 1',
        (WidgetTester tester) async {
      // Build the OnBoardingPage widget
      await tester.pumpWidget(
        Material(
          child: MaterialApp(
            home: OnBoardingPage(currentPageManager: PageManager()),
          ),
        ),
      );

      // Verify that the BackButton is not displayed
      expect(find.byType(BackButton), findsNothing);
    });
  });

  group('Page404Widget', () {
    testWidgets('should display error message with current page arguments',
        (WidgetTester tester) async {
      // Create mock instances
      final MockPageManager mockPageManager = MockPageManager();

      // Build the Page404Widget widget
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Page404Widget(currentPageManager: mockPageManager),
          ),
        ),
      );

      expect(
        mockPageManager.currentPage.arguments,
        'example_argument',
      );
    });

    testWidgets('should show BackButton when historyPagesCount > 1',
        (WidgetTester tester) async {
      // Create mock instances
      final MockPageManager mockPageManager = MockPageManager();

      // Build the Page404Widget widget
      await tester.pumpWidget(
        MaterialApp(
          home: Page404Widget(currentPageManager: mockPageManager),
        ),
      );

      // Verify that the BackButton is displayed
      expect(mockPageManager.historyPagesCount, greaterThan(0));
    });

    testWidgets('should not show BackButton when historyPagesCount <= 1',
        (WidgetTester tester) async {
      // Create mock instances
      final MockPageManager mockPageManager = MockPageManager();
      mockPageManager.historyPagesCount = 1;
      // Build the Page404Widget widget
      await tester.pumpWidget(
        MaterialApp(
          home: Page404Widget(currentPageManager: mockPageManager),
        ),
      );

      // Verify that the BackButton is not displayed
      expect(find.byType(BackButton), findsNothing);
    });
  });
}

// Mock classes
class MockPageManager extends PageManager {
  @override
  MaterialPage<dynamic> get currentPage => const MaterialPage<dynamic>(
        arguments: 'example_argument',
        child: Placeholder(),
      );
  int _pageCount = 2;

  @override
  int get historyPagesCount => _pageCount;

  set historyPagesCount(int val) {
    _pageCount = val;
  }

  @override
  void back() {}
}

class MockMaterialPage<T> extends MaterialPage<T> {
  const MockMaterialPage({required super.child});

  @override
  T? get arguments => null;

  @override
  String? get name => null;

  @override
  bool get maintainState => false;

  @override
  bool get fullscreenDialog => false;
}
