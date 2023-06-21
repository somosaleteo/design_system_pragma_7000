import 'package:flutter/material.dart';

class MenuSide extends StatelessWidget {
  const MenuSide({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: const <Widget>[
            DrawerHeader(
              child: _MenuHeader(),
            ),
            _MenuOption(
              textOption: 'Empieza a diseñar',
              children: [
                _SecondaryOption(text: 'Instalación librería'),
                _SecondaryOption(text: 'Colaboración'),
                _SecondaryOption(text: 'Personalización'),
                _SecondaryOption(text: 'Reutilizar componentes'),
              ],
            ),
            _MenuOption(
              textOption: 'Empieza a desarrollar',
              children: [],
            ),
            _MenuOption(
              textOption: 'Guía de estilos',
              children: [],
            ),
            _MenuOption(
              textOption: 'Componentes',
              children: [
                _SecondaryOption(
                  text: 'Accordion',
                ),
                _SecondaryOption(text: 'Avatar'),
                _SecondaryOption(text: 'Button'),
                _SecondaryOption(text: 'Icon button'),
                _SecondaryOption(text: 'Breadcrumbs'),
                _SecondaryOption(text: 'Calendar'),
                _SecondaryOption(text: 'Card'),
                _SecondaryOption(text: 'Filters'),
                _SecondaryOption(text: 'Inputs'),
                _SecondaryOption(text: 'Loading'),
                _SecondaryOption(text: 'Pagination'),
                _SecondaryOption(text: 'Radio button'),
                _SecondaryOption(text: 'Search'),
                _SecondaryOption(text: 'Stepper'),
                _SecondaryOption(text: 'Tabs'),
                _SecondaryOption(text: 'Tables'),
                _SecondaryOption(text: 'Tags'),
                _SecondaryOption(text: 'Text area'),
                _SecondaryOption(text: 'Toast'),
                _SecondaryOption(text: 'Toggle'),
                _SecondaryOption(text: 'Tooltip'),
              ],
            ),
            _MenuOption(
              textOption: 'Componentes #Pragma7000',
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuHeader extends StatelessWidget {
  const _MenuHeader();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            const SizedBox(width: 10.0),
            const Text(
              '| ',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
            ),
            const Text('Pragma '),
            const Text(
              'Design System ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const Text('v 2.0', style: TextStyle(fontSize: 12.0)),
          ],
        ),
        const SizedBox(height: 25.0),
        const _InputSearch(),
      ],
    );
  }
}

class _InputSearch extends StatelessWidget {
  const _InputSearch();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        label:  Text('Busca componentes'),
        contentPadding:  EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        suffixIcon:  Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: CircleAvatar(
            child: Icon(Icons.search, size: 20),
          ),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
   const _MenuOption({
    required this.textOption,
    required this.children,
  });
  final String textOption;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Text(textOption),
      ),
      shape: const Border(),
      childrenPadding: const EdgeInsets.only(left: 25.0),
      children: children,
    );
  }
}

class _SecondaryOption extends StatelessWidget {
  const _SecondaryOption({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(text),
        ),
      ),
    );
  }
}
