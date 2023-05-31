import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

class ButtonDetail extends StatelessWidget {
  const ButtonDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      withAppbar: true,
      child: Container(
        color: Colors.amber,
        child: const Text(
          'Funcionó :)',
        ),
      ),
    );
  }
}
