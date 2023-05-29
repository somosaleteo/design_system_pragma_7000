import 'package:aleteo_arquetipo/ui/widgets/responsive/basic_components/basic_custom_responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BasicCustomWidget renders child with correct size',
      (WidgetTester tester) async {
    // Arrange
    final Container childWidget = Container();
    const double width = 10.0;
    const double aspectRatio = 1.0;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: BasicCustomWidget(
            child: childWidget,
          ),
        ),
      ),
    );

    // Assert
    final Finder sizedBoxFinder = find.byType(SizedBox);
    expect(sizedBoxFinder, findsOneWidget);

    final SizedBox sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
    expect(sizedBox.width, equals(width));
    expect(sizedBox.height, equals(width * aspectRatio));

    final Finder childFinder = find.byWidget(childWidget);
    expect(childFinder, findsOneWidget);
  });
}
