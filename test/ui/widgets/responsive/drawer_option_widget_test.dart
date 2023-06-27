import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing for drawer', () {
    testWidgets('onPressed is called when ListTile is tapped',
        (WidgetTester tester) async {
      const Key key = Key('listTileWidget');
      const bool onPressedCalled = false;
      await tester.pumpWidget(
        const MaterialApp(
          home: Material(
            child: Scaffold(
             /*  body: Builder(
                builder: (BuildContext context) => DrawerOptionWidget(
                  key: key,
                  onPressed: () {
                    onPressedCalled = true;
                  },
                  title: 'Test',
                  icondata: Icons.ac_unit,
                ),
              ), */
            ),
          ),
        ),
      );
      final Finder listTile = find.byKey(key);
      await tester.tap(listTile);
      expect(onPressedCalled, true);
    });
  });
}
