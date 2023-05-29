import 'package:flutter/material.dart';

import '../../../blocs/bloc_responsive.dart';

class WorkAreaWidget extends StatelessWidget {
  const WorkAreaWidget({
    required this.child,
    required this.withMargin,
    required this.responsiveBloc,
    super.key,
  });

  final Widget? child;
  final bool withMargin;
  final ResponsiveBloc responsiveBloc;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        responsiveBloc.workAreaSize =
            Size(constraints.maxWidth, constraints.maxHeight);
        if (withMargin) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: responsiveBloc.marginWidth),
              child: child ?? const SizedBox(),
            ),
          );
        }
        return child ?? const SizedBox();
      },
    );
  }
}
