import 'package:aleteo_arquetipo/ui/widgets/custom_fat_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomFatButtonWidget', () {
    testWidgets('renders label and icon', (WidgetTester tester) async {
      const CustomFatButtonWidget widget = CustomFatButtonWidget(
        label: 'My Label',
        iconData: Icons.ac_unit,
      );
      await tester.pumpWidget(const MaterialApp(home: widget));
      final Finder labelFinder = find.text('My Label');
      final Finder iconFinder = find.byIcon(Icons.ac_unit);
      expect(labelFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets('executes function when pressed', (WidgetTester tester) async {
      bool executed = false;
      final CustomFatButtonWidget widget =
          CustomFatButtonWidget(function: () => executed = true);
      await tester.pumpWidget(MaterialApp(home: widget));
      final Finder buttonFinder = find.byType(MaterialButton);
      expect(buttonFinder, findsOneWidget);
      await tester.tap(buttonFinder);
      expect(executed, isTrue);
    });

    testWidgets('renders default label and icon when not provided',
        (WidgetTester tester) async {
      const CustomFatButtonWidget widget = CustomFatButtonWidget();
      await tester.pumpWidget(const MaterialApp(home: widget));
      final Finder labelFinder = find.text('Push me');
      final Finder iconFinder = find.byIcon(Icons.adb);
      expect(labelFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });
  });
}
