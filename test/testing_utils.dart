/*

import 'package:flutter/material.dart';

void printWidgetTree(Widget widget, [String prefix = '']) {
  debugPrint('$prefix${widget.runtimeType}');
  if (widget is StatelessWidget) {
    return;
  }
  if (widget is StatefulWidget) {
    final State<StatefulWidget> state = widget.createState();
    printWidgetTree(state.build(state.context), '$prefix  ');
  }
  if (widget is ParentDataWidget) {
    printWidgetTree(widget.child, '$prefix  ');
  }
  if (widget is MultiChildRenderObjectWidget) {
    for (final Widget child in widget.children) {
      printWidgetTree(child, '$prefix  ');
    }
  }
}
*/
