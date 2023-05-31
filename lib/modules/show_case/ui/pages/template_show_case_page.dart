import 'package:aleteo_arquetipo/ui/widgets/responsive/my_app_scaffold_widget.dart';
import 'package:flutter/material.dart';

class TemplateShowCase extends StatelessWidget {
  const TemplateShowCase({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      child: Column(
        children: <Widget>[
          const Text('Button'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('template'),
          ),
          const Text('Aqui va el código'),
          Expanded(
            child: GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 3,
                crossAxisCount: 100
              ),
              itemCount: 100, //lista de propiedades
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                  width: 100,
                  height: 100,
                    color: Colors.amber, child: const Text('propiedad'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
