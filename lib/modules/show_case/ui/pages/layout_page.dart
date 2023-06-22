import 'package:aleteo_arquetipo/modules/show_case/ui/widgets/library_layout_design_system.dart';
import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/feedback_widget.dart';

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
              children: [
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
