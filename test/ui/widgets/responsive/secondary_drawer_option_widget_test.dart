import 'package:aleteo_arquetipo/ui/widgets/responsive/secondary_drawer_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_secondary_drawer_bloc.dart';

void main() {
  group('SecondarydrawerOptionWidget', () {
    late VoidCallback onPressed;
    late IconData icondata;
    late String toolTip;
    late MockSecondaryDrawerBloc secondaryDrawerBloc;

    setUp(() {
      onPressed = () => <String, dynamic>{};
      icondata = Icons.add;
      toolTip = 'Add';
      secondaryDrawerBloc = MockSecondaryDrawerBloc();
    });

    testWidgets('returns FloatingActionButton on mobile',
        (WidgetTester tester) async {
      const Key key = Key('testKey');
      secondaryDrawerBloc.isMovil = true;
      final MaterialApp widget = MaterialApp(
        home: Scaffold(
          body: SecondaryDrawerOptionWidget(
            key: key,
            onPressed: onPressed,
            icondata: icondata,
            toolTip: toolTip,
            secondaryMenuBloc: secondaryDrawerBloc,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      try {
        expect(find.byKey(key), findsOneWidget);
      } catch (e) {
        fail('FloatingActionButton not found: $e');
      }
    });

    testWidgets('returns ListTile on desktop', (WidgetTester tester) async {
      secondaryDrawerBloc.isMovil = false;
      final MaterialApp widget = MaterialApp(
        home: Material(
          child: Scaffold(
            body: SecondaryDrawerOptionWidget(
              onPressed: onPressed,
              icondata: icondata,
              toolTip: toolTip,
              secondaryMenuBloc: secondaryDrawerBloc,
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('tapping on FloatingActionButton calls onPressed',
        (WidgetTester tester) async {
      bool tapped = false;
      onPressed = () => tapped = true;
      secondaryDrawerBloc.isMovil = true;
      final MaterialApp widget = MaterialApp(
        home: Material(
          child: Scaffold(
            body: SecondaryDrawerOptionWidget(
              onPressed: onPressed,
              icondata: icondata,
              toolTip: toolTip,
              secondaryMenuBloc: secondaryDrawerBloc,
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.tap(find.byType(FloatingActionButton));

      expect(tapped, isTrue);
    });

    testWidgets('tapping on ListTile calls onPressed',
        (WidgetTester tester) async {
      bool tapped = false;
      onPressed = () => tapped = true;
      secondaryDrawerBloc.isMovil = false;
      final MaterialApp widget = MaterialApp(
        home: Material(
          child: Scaffold(
            body: SecondaryDrawerOptionWidget(
              onPressed: onPressed,
              icondata: icondata,
              toolTip: toolTip,
              secondaryMenuBloc: secondaryDrawerBloc,
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.tap(find.byType(ListTile));

      expect(tapped, isTrue);
    });
  });
}
