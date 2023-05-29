import 'package:aleteo_arquetipo/ui/widgets/responsive/basic_components/basic_custom_aspect_ratio_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mock_bloc_responsive.dart';

void main() {
  group('BasicCustomAspectRatioWidget', () {
    late MockResponsiveBloc responsiveBloc;
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
      const double aspectRatio = 1.5;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BasicCustomAspectRatioWidget(
            responsiveBloc: responsiveBloc,
            numberOfColumns: numberOfColumns,
            aspectRatio: aspectRatio,
            child: childWidget,
          ),
        ),
      );

      // Assert
      final Finder sizedBoxFinder = find.byType(SizedBox);
      expect(sizedBoxFinder, findsOneWidget);

      final SizedBox sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      const double expectedWidth = 380.0;
      const double expectedHeight = expectedWidth * aspectRatio;
      expect(sizedBox.width, equals(expectedWidth));
      expect(sizedBox.height, equals(expectedHeight));

      final Finder childFinder = find.byWidget(childWidget);
      expect(childFinder, findsOneWidget);
    });
  });
}
