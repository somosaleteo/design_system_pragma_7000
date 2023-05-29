import 'package:aleteo_arquetipo/ui/widgets/responsive/basic_components/basic_3_x_1_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mock_bloc_responsive.dart';

void main() {
  late MockResponsiveBloc responsiveBloc;
  group('Basic3x1Widget', () {
    setUp(() {
      responsiveBloc = MockResponsiveBloc();
      responsiveBloc.setSizeForTesting(
        const Size(800.0, 600.0),
      );
    });

    tearDown(() {
      responsiveBloc.dispose();
    });

    testWidgets('renders child with correct size', (WidgetTester tester) async {
      // Arrange

      final Container childWidget = Container();
      const int numberOfColumns = 2;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Basic3x1Widget(
              responsiveBloc: responsiveBloc,
              numberOfColumns: numberOfColumns,
              child: childWidget,
            ),
          ),
        ),
      );

      // Assert
      final Finder sizedBoxFinder = find.byType(SizedBox);
      expect(sizedBoxFinder, findsOneWidget);

      final SizedBox sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      const double expectedWidth = 380.0;
      const double expectedHeight = expectedWidth / 3;
      expect(sizedBox.width, equals(expectedWidth));
      expect(sizedBox.height, equals(expectedHeight));

      final Finder childFinder = find.byWidget(childWidget);
      expect(childFinder, findsOneWidget);
    });
  });
}
