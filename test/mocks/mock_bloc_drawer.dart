// ignore_for_file: require_trailing_commas

import 'package:aleteo_arquetipo/blocs/bloc_drawer.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/drawer_option_widget.dart';

void testMe() {}

class MockDrawerMainMenuBloc extends DrawerMainMenuBloc {
  @override
  Stream<List<DrawerOptionWidget>> get listDrawerOptionSizeStream =>
      Stream<List<DrawerOptionWidget>>.value(listMenuOptions);

/*   @override
  List<DrawerOptionWidget> get listMenuOptions => <DrawerOptionWidget>[
        const DrawerOptionWidget(
          title: 'title',
          onPressed: testMe,
          description: 'description',
          icondata: Icons.add,
        )
      ]; */

  @override
  void clearMainDrawer() {}

/*   @override
  void addDrawerOptionMenu({
    VoidCallback onPressed = testMe,
    String title = 'Prueba',
    String description = '',
    IconData icondata = Icons.add,
  }) {
    final List<DrawerOptionWidget> tmp = <DrawerOptionWidget>[
      ...listMenuOptions
    ];
    tmp.add(DrawerOptionWidget(
      title: title,
      onPressed: onPressed,
      description: description,
      icondata: icondata,
    ));
  } */

  @override
  void removeDrawerOptionMenu(String title) {}
  bool isOpen = false;
  @override
  void openDrawer() {
    isOpen = true;
  }

  @override
  void closeDrawer() {
    isOpen = false;
  }

  @override
  void dispose() {}
}
