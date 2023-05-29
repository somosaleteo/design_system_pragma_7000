// ignore_for_file: require_trailing_commas

import 'package:aleteo_arquetipo/blocs/bloc_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponsiveBloc', () {
    late ResponsiveBloc responsiveBloc;

    setUp(() {
      responsiveBloc = ResponsiveBloc();
    });

    tearDown(() {
      responsiveBloc.dispose();
    });
    test('Initial value is (1,1)', () {
      expect(responsiveBloc.value, const Size(1, 1));
    });
    test('appScreenSizeStream - default value', () {
      const Size expectedSize = Size(1, 1);

      expectLater(responsiveBloc.appScreenSizeStream, emits(expectedSize));
    });
    testWidgets('Change screen size', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            responsiveBloc.setSizeFromContext(context);
            return Container();
          },
        ),
      ));

      // final Size sizeTmp =
      //     tester.view.physicalSize / tester.view.devicePixelRatio;

      // expect(responsiveBloc.value, sizeTmp);

      responsiveBloc.workAreaSize = const Size(600, 800);
      expect(responsiveBloc.columnWidth, 60.0);

      responsiveBloc.workAreaSize = const Size(1200, 800);
      expect(responsiveBloc.columnWidth, 135.0);

      responsiveBloc.workAreaSize = const Size(1920, 1080);
      expect(responsiveBloc.columnWidth, greaterThan(145.0));
      responsiveBloc.workAreaSize = const Size(600, 800);

      expect(responsiveBloc.widthByColumns(1), 60.0);
      expect(responsiveBloc.widthByColumns(2), 128.0);
      expect(responsiveBloc.widthByColumns(3), 196.0);

      responsiveBloc.workAreaSize = const Size(1200, 800);
      expect(responsiveBloc.widthByColumns(1), 135.0);
      expect(responsiveBloc.widthByColumns(2), 278.0);
      expect(responsiveBloc.widthByColumns(3), 421.0);

      responsiveBloc.setSizeForTesting(const Size(320, 800));
      expect(responsiveBloc.getDeviceType, ScreenSizeEnum.movil);

      responsiveBloc.setSizeForTesting(const Size(900, 800));
      expect(responsiveBloc.getDeviceType, ScreenSizeEnum.tablet);

      responsiveBloc.setSizeForTesting(const Size(1200, 800));
      expect(responsiveBloc.getDeviceType, ScreenSizeEnum.desktop);

      responsiveBloc.setSizeForTesting(const Size(520, 800));
      expect(responsiveBloc.isMovil, true);

      responsiveBloc.setSizeForTesting(const Size(900, 800));
      expect(responsiveBloc.isMovil, false);

      responsiveBloc.setSizeForTesting(const Size(1600, 900));
      expect(responsiveBloc.getDeviceType, ScreenSizeEnum.desktop);
    });
  });
}
