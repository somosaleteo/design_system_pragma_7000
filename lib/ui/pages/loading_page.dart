import 'package:flutter/material.dart';

import '../../blocs/bloc_processing.dart';
import '../../blocs/bloc_responsive.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    required this.blocProcessing,
    required this.blocResponsive,
    super.key,
  });

  final BlocProcessing blocProcessing;
  final ResponsiveBloc blocResponsive;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: blocProcessing.procesingStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (blocProcessing.isProcessing) {
          final Color primaryColor = Theme.of(context).primaryColor;
          final Color textColor = Theme.of(context).canvasColor;

          return Opacity(
            opacity: 0.90,
            child: Material(
              color: primaryColor,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: double.infinity,
                      ),
                      CircularProgressIndicator(
                        color: textColor,
                        strokeWidth: 7.0,
                      ),
                      SizedBox(
                        height: blocResponsive.gutterWidth,
                      ),
                      Text(
                        blocProcessing.procesingMsg,
                        style: TextStyle(color: textColor),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
