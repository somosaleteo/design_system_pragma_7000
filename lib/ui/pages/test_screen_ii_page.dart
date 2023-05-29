import 'dart:math';

import 'package:flutter/material.dart';

import '../../app_config.dart';
import '../../blocs/bloc_responsive.dart';
import '../widgets/responsive/material_basic_layout_widget.dart';
import '../widgets/responsive/my_app_scaffold_widget.dart';

class TestScreenIIPage extends StatefulWidget {
  const TestScreenIIPage({
    required this.blocResponsive,
    super.key,
    this.widget,
  });
  final Widget? widget;
  final ResponsiveBloc blocResponsive;

  @override
  State<TestScreenIIPage> createState() => _TestScreenIIPageState();
}

class _TestScreenIIPageState extends State<TestScreenIIPage> {
  final List<Size> _sizeMap = <Size>[];
  int index = 0;
  final List<IconData> icondataList = <IconData>[
    Icons.add,
    Icons.tab,
    Icons.stream,
    Icons.update,
    Icons.height,
    Icons.description
  ];

  @override
  void dispose() {
    _sizeMap.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_sizeMap.isEmpty) {
      final Size size = widget.blocResponsive.size;
      final double maxUnit = max(size.width, size.height) / 2;

      _sizeMap.add(Size(maxUnit, maxUnit * .25));
      _sizeMap.add(Size(maxUnit, maxUnit / 3));
      _sizeMap.add(Size(maxUnit, maxUnit / 2));
      _sizeMap.add(Size(maxUnit, maxUnit * 2));
    }
    return MyAppScaffold(
      withMargin: false,
      child: MaterialBasicLayoutWidget(
        responsiveBloc:
            blocCore.getBlocModule<ResponsiveBloc>(ResponsiveBloc.name),
      ),
    );
  }
}
