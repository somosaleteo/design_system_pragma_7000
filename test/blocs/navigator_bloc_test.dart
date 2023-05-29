// ignore_for_file: require_trailing_commas

import 'package:aleteo_arquetipo/blocs/navigator_bloc.dart';
import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavigatorBloc', () {
    late PageManager pageManager;
    late NavigatorBloc navigatorBloc;

    setUp(() {
      pageManager = PageManager();
      navigatorBloc = NavigatorBloc(pageManager);
    });
    tearDown(() {
      navigatorBloc.dispose();
    });

    test('initial values', () {
      expect(navigatorBloc.title, '');
      expect(navigatorBloc.historyPageLength, 1);
      expect(navigatorBloc.directoryOfRoutes, <String>['/', '/404']);
    });

    test('setTitle', () {
      const String title = 'My Title';
      navigatorBloc.setTitle(title);
      expect(navigatorBloc.title, title);
    });

    test('setHomePage', () {
      const Text homePage = Text('Home Page');
      navigatorBloc.setHomePage(homePage);
      expect(navigatorBloc.historyPageLength, 1);
    });
    test('setHomePageAndUpdate', () {
      const Text homePage = Text('Home Page');
      navigatorBloc.setHomePageAndUpdate(homePage);
      expect(navigatorBloc.historyPageLength, 1);
    });

    test('pushPage', () {
      const String routeName = '/page';
      const Text widget = Text('My Page');
      navigatorBloc.pushPage(routeName, widget);
      expect(navigatorBloc.historyPageLength, 2);
      expect(navigatorBloc.directoryOfRoutes.contains(routeName), true);
    });

    test('pushAndReplacement', () {
      const String routeName = '/page';
      const Text widget = Text('My Page');
      navigatorBloc.pushAndReplacement(routeName, widget);
      expect(navigatorBloc.historyPageLength, 2);
      expect(navigatorBloc.directoryOfRoutes.contains(routeName), true);
    });

    test('pushNamedAndReplacement', () {
      const String routeName = '/page';
      navigatorBloc.pushNamedAndReplacement(routeName);
      expect(navigatorBloc.historyPageLength, 2);
      expect(navigatorBloc.directoryOfRoutes.contains(routeName), true);
    });

    test('pushPageWidthTitle', () {
      const String title = 'My Page Title';
      const String routeName = '/page';
      const Text widget = Text('My Page');
      navigatorBloc.pushPageWidthTitle(title, routeName, widget);
      expect(navigatorBloc.historyPageLength, 2);
      expect(navigatorBloc.directoryOfRoutes.contains(routeName), true);
      expect(navigatorBloc.title, title);
    });

    test('addPagesForDynamicLinksDirectory', () {
      const String routeName = '/page';
      const Text widget = Text('My Page');
      navigatorBloc.addPagesForDynamicLinksDirectory(<String, Widget>{
        routeName: widget,
      });
      expect(navigatorBloc.directoryOfRoutes.contains(routeName), true);
    });

    test('removePageFromHistory', () {
      const String routeName = '/page';
      const Text widget = Text('My Page');
      navigatorBloc.pushPage(routeName, widget);
      expect(navigatorBloc.directoryOfRoutes.contains(routeName), true);
      navigatorBloc.removePageFromHistory(routeName);
      expect(navigatorBloc.directoryOfRoutes.contains(routeName), false);
    });

    test('clearAndGoHome', () {
      const Text homePage = Text('Home Page');
      const String routeName = '/page';
      const Text widget = Text('My Page');
      navigatorBloc.setHomePage(homePage);
      navigatorBloc.pushPage(routeName, widget);
      expect(navigatorBloc.historyPageLength, 2);
      navigatorBloc.clearAndGoHome();
      expect(navigatorBloc.historyPageLength, 1);
    });
  });
  test('pushNamed', () {
    const String routeName = '/page';
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());
    navigatorBloc.addPagesForDynamicLinksDirectory(
        <String, Widget>{routeName: const Center()});
    navigatorBloc.pushNamed(routeName);
    expect(navigatorBloc.directoryOfRoutes.contains(routeName), true);
  });

  test('pushPageWidthTitle', () {
    const String title = 'Test';
    const String routeName = '/page';
    const Placeholder widget = Placeholder();
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());

    navigatorBloc.pushPageWidthTitle(title, routeName, widget);

    expect(navigatorBloc.directoryOfRoutes.contains(routeName), isTrue);
    expect(navigatorBloc.title, title);
  });

  test('pushPage', () {
    const String routeName = '/page';
    const Placeholder widget = Placeholder();
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());

    navigatorBloc.pushPage(routeName, widget);

    expect(navigatorBloc.directoryOfRoutes.contains(routeName), isTrue);
  });

  test('pushAndReplacement', () {
    const String routeName = '/page';
    const Placeholder widget = Placeholder();
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());

    navigatorBloc.pushAndReplacement(routeName, widget);

    expect(navigatorBloc.directoryOfRoutes, <String>['/', '/404', routeName]);
  });

  test('pushNamedAndReplacement', () {
    const String routeName = '/page';
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());

    navigatorBloc.pushNamedAndReplacement(routeName);

    expect(navigatorBloc.directoryOfRoutes.contains(routeName), isTrue);
  });

  test('addPagesForDynamicLinksDirectory', () {
    const String routeName1 = '/page1';
    const String routeName2 = '/page2';
    const Placeholder widget1 = Placeholder();
    const Placeholder widget2 = Placeholder();
    final Map<String, Widget> mapOfPages = <String, Widget>{
      routeName1: widget1,
      routeName2: widget2,
    };
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());

    navigatorBloc.addPagesForDynamicLinksDirectory(mapOfPages);

    expect(navigatorBloc.directoryOfRoutes.contains(routeName1), isTrue);
    expect(navigatorBloc.directoryOfRoutes.contains(routeName2), isTrue);
  });

  test('removePageFromHistory', () {
    const String routeName = '/page';
    const Placeholder widget = Placeholder();
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());
    navigatorBloc.pushPage(routeName, widget);

    navigatorBloc.removePageFromHistory(routeName);

    expect(navigatorBloc.directoryOfRoutes, <String>['/', '/404']);
  });

  test('clearAndGoHome', () {
    const String routeName = '/page';
    const Placeholder widget = Placeholder();
    final NavigatorBloc navigatorBloc = NavigatorBloc(PageManager());
    navigatorBloc.pushPage(routeName, widget);

    navigatorBloc.clearAndGoHome();

    expect(navigatorBloc.historyPageNames, <String>['/']);
  });

  test('dispose', () async {
    final PageManager pageManager = PageManager();
    final NavigatorBloc navigatorBloc = NavigatorBloc(pageManager);

    await navigatorBloc.dispose();

    expect(pageManager.historyPagesCount, equals(0));
  });
}
