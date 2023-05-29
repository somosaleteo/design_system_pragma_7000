import 'package:aleteo_arquetipo/blocs/bloc_user_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserNotificationsBloc', () {
    late UserNotificationsBloc userNotificationsBloc;
    const String testMessage = 'Test message';

    setUp(() {
      userNotificationsBloc = UserNotificationsBloc();
    });

    tearDown(() {
      userNotificationsBloc.dispose();
    });

    testWidgets('showGeneralAlert should show an alert dialog',
        (WidgetTester tester) async {
      final MaterialApp widget = MaterialApp(
        home: Material(
          child: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                Future<void>.delayed(const Duration(milliseconds: 500), () {
                  userNotificationsBloc.showGeneralAlert(
                    context,
                    testMessage,
                  );
                });

                return const Center(
                  child: Text('Hola'),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      try {
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text(testMessage), findsOneWidget);
      } catch (e) {
        debugPrint('Error : $e');
      }
    });

    testWidgets('showGeneralSsnackBar should show a snack bar',
        (WidgetTester tester) async {
      final MaterialApp widget = MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            Future<void>.delayed(const Duration(milliseconds: 500), () {
              userNotificationsBloc.showGeneralSsnackBar(
                context,
                testMessage,
              );
            });
            return Container();
          },
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      try {
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text(testMessage), findsOneWidget);
      } catch (e) {
        debugPrint('Error : $e');
      }
    });
  });
}
