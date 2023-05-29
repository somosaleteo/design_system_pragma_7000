import 'package:flutter/material.dart';

import 'secondary_drawer_option_widget.dart';

class MyFloatingActionButtonWidget extends StatelessWidget {
  const MyFloatingActionButtonWidget({
    required this.listMenuOptions,
    super.key,
  });
  final List<SecondaryDrawerOptionWidget> listMenuOptions;

  @override
  Widget build(BuildContext context) {
    if (listMenuOptions.isEmpty) {
      return const SizedBox();
    }
    if (listMenuOptions.length == 1) {
      return listMenuOptions.first;
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: listMenuOptions,
      ),
    );
  }
}
