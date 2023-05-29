import 'package:aleteo_arquetipo/blocs/bloc_drawer.dart';
import 'package:aleteo_arquetipo/blocs/bloc_processing.dart';
import 'package:aleteo_arquetipo/blocs/bloc_responsive.dart';
import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/blocs/navigator_bloc.dart';
import 'package:aleteo_arquetipo/entities/entity_bloc.dart';
import 'package:aleteo_arquetipo/providers/my_app_navigator_provider.dart';
import 'package:aleteo_arquetipo/ui/widgets/forms/background_form_widget.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_bloc_drawer.dart';
import '../../../mocks/mock_bloc_processing.dart';
import '../../../mocks/mock_bloc_responsive.dart';
import '../../../mocks/mock_navigator_bloc.dart';
import '../../../mocks/mock_secondary_drawer_bloc.dart';

void main() {
  late BlocCore<dynamic> blocCoreExt;
  late MockResponsiveBloc responsiveBloc;
  late MockDrawerMainMenuBloc drawerMainMenuBloc;
  late MockSecondaryDrawerBloc drawerSecondaryMenuBloc;
  late MockNavigatorBloc navigatorBloc;
  late MockBlocProcessing blocProcessing;
  late PageManager pageManager;

  setUp(() async {
    pageManager = PageManager();
    responsiveBloc = MockResponsiveBloc();
    drawerMainMenuBloc = MockDrawerMainMenuBloc();
    drawerSecondaryMenuBloc = MockSecondaryDrawerBloc();
    drawerSecondaryMenuBloc.isMovil = true;
    navigatorBloc = MockNavigatorBloc(pageManager);
    blocProcessing = MockBlocProcessing();
    await Future<void>.delayed(const Duration(seconds: 1));
    blocCoreExt = BlocCore<dynamic>();
    blocCoreExt.addBlocModule<NavigatorBloc>(
      NavigatorBloc.name,
      navigatorBloc,
    );
    blocCoreExt.addBlocModule<ResponsiveBloc>(
      ResponsiveBloc.name,
      responsiveBloc,
    );
    blocCoreExt.addBlocModule<DrawerMainMenuBloc>(
      DrawerMainMenuBloc.name,
      drawerMainMenuBloc,
    );
    blocCoreExt.addBlocModule<DrawerSecondaryMenuBloc>(
      DrawerSecondaryMenuBloc.name,
      drawerSecondaryMenuBloc,
    );
    blocCoreExt.addBlocModule<BlocProcessing>(
      BlocProcessing.name,
      blocProcessing,
    );
  });

  tearDown(() {
    blocCoreExt.dispose();
  });

  testWidgets('Test BackgroudFormBuilderWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BackgroudFormBuilderWidget(
          blocCoreExt: blocCoreExt,
          children: <Widget>[
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );

    // Verifica que el widget MyAppScaffold tenga una instancia de blocCoreExt igual a blocCoreMock
    final Finder myAppScaffoldFinder = find.byType(MyAppScaffold);
    expect(myAppScaffoldFinder, findsOneWidget);

    final MyAppScaffold myAppScaffoldWidget =
        tester.widget<MyAppScaffold>(myAppScaffoldFinder);
    expect(
      myAppScaffoldWidget.blocCoreExt,
      equals(blocCoreExt),
    );

    // Verifica que el ListView.builder tenga el número correcto de children
    final Finder listViewFinder = find.byType(ListView);
    expect(
      listViewFinder,
      findsAtLeastNWidgets(1),
    );
  });
}
