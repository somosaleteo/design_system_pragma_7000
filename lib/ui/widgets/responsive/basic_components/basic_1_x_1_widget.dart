import 'package:flutter/material.dart';

import '../../../../blocs/bloc_responsive.dart';

class Basic1x1Widget extends StatelessWidget {
  const Basic1x1Widget({
    required this.responsiveBloc,
    super.key,
    this.numberOfColumns = 1,
    this.child,
  });

  final int numberOfColumns;
  final Widget? child;
  final ResponsiveBloc responsiveBloc;

  @override
  Widget build(BuildContext context) {
    final double width = responsiveBloc.widthByColumns(numberOfColumns);
    return SizedBox(
      width: width,
      height: width,
      child: child,
    );
  }
}
