import 'package:flutter/material.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';

class TemplateShowCase extends StatelessWidget {
  const TemplateShowCase({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text('Button'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('template'),
            ),
            const Text('Aqui va el código'),
            const _PropertyHeader(),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 50,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _Property(text: 'Name $index'),
                    _Property(text: 'Description $index'),
                    _Property(text: 'Default $index'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyHeader extends StatelessWidget {
  const _PropertyHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _Property(text: "Name"),
        _Property(text: "Description"),
        _Property(text: "Default"),
      ],
    );
  }
}

class _Property extends StatelessWidget {
  const _Property({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Text(text)),
    );
  }
}
