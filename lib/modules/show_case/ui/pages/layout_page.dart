import 'package:flutter/material.dart';

import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../widgets/feedback_widget.dart';
import '../widgets/library_layout_design_system.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF330072);
    return const MyAppScaffold(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                LibraryLayoutDesignSystem(),
                FeedbackWidget(mainColor: mainColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
