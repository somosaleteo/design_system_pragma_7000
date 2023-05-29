import 'package:flutter/material.dart';

import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/bloc_demo.dart';

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({
    required this.blocDemo,
    super.key,
    this.isTesting = false,
  });
  final BlocDemo blocDemo;
  final bool isTesting;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      alignment: Alignment.center,
      color: Theme.of(context).dialogBackgroundColor,
      child: StreamBuilder<int>(
        stream: blocDemo.counterStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text(blocDemo.counter.toString());
        },
      ),
    );
    if (isTesting) {
      return Scaffold(
        body: content,
      );
    }
    return MyAppScaffold(
      child: content,
    );
  }
}
