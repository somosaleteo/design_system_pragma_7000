import 'package:aleteo_arquetipo/blocs/bloc_secondary_drawer.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_floating_action_button_widget.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/secondary_drawer_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_secondary_drawer_bloc.dart';

class MockSecondaryDrawerOptionWidget extends SecondaryDrawerOptionWidget {
  const MockSecondaryDrawerOptionWidget({
    required super.onPressed,
    required super.icondata,
    required super.secondaryMenuBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Implementar el comportamiento esperado para la clase mock
    return Container();
  }
}

void main() {
  void testMe() {}
  const IconData icondata = Icons.add;

  late DrawerSecondaryMenuBloc secondaryMenuBloc;
  setUp(() {
    secondaryMenuBloc = MockSecondaryDrawerBloc();
  });

  testWidgets('Test MyFloatingActionButtonWidget', (WidgetTester tester) async {
    // Crear una lista de opciones de drawer mock
    final List<SecondaryDrawerOptionWidget> mockMenuOptions =
        <SecondaryDrawerOptionWidget>[
      MockSecondaryDrawerOptionWidget(
        icondata: icondata,
        onPressed: testMe,
        secondaryMenuBloc: secondaryMenuBloc,
      ),
      MockSecondaryDrawerOptionWidget(
        icondata: icondata,
        onPressed: testMe,
        secondaryMenuBloc: secondaryMenuBloc,
      ),
    ];

    // Construir el widget bajo prueba
    await tester.pumpWidget(
      MaterialApp(
        home: MyFloatingActionButtonWidget(listMenuOptions: mockMenuOptions),
      ),
    );

    // Realizar las aserciones y las pruebas necesarias
    if (mockMenuOptions.isEmpty) {
      expect(find.byType(SizedBox), findsOneWidget);
    } else if (mockMenuOptions.length == 1) {
      expect(find.byType(MockSecondaryDrawerOptionWidget), findsOneWidget);
    } else {
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(
        find.byType(MockSecondaryDrawerOptionWidget),
        findsNWidgets(mockMenuOptions.length),
      );
    }
  });
  testWidgets('return first option when length is 1',
      (WidgetTester tester) async {
    final MockSecondaryDrawerOptionWidget option =
        MockSecondaryDrawerOptionWidget(
      onPressed: () {},
      icondata: Icons.add,
      secondaryMenuBloc: secondaryMenuBloc,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MyFloatingActionButtonWidget(
          listMenuOptions: <SecondaryDrawerOptionWidget>[option],
        ),
      ),
    );

    expect(find.byWidget(option), findsOneWidget);
  });

  testWidgets('return SizedBox when length is 0', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyFloatingActionButtonWidget(
          listMenuOptions: <SecondaryDrawerOptionWidget>[],
        ),
      ),
    );

    expect(find.byType(SizedBox), findsOneWidget);
  });
}
