import 'package:flutter/material.dart';

import '../../../entities/entity_bloc.dart';
import '../responsive/my_app_scaffold_widget.dart';

class BackgroudFormBuilderWidget extends StatelessWidget {
  const BackgroudFormBuilderWidget({
    required this.children,
    super.key,
    this.blocCoreExt,
  });

  final List<Widget> children;
  // PAra efectos de "infernal testing"
  final BlocCore<dynamic>? blocCoreExt;

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      blocCoreExt: blocCoreExt,
      child: ListView.builder(
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) => children[index],
      ),
    );
  }
}
