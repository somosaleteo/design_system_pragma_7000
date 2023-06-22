
import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});
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
        label: Text('Busca componentes'),
        contentPadding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: CircleAvatar(
            child: Icon(Icons.search, size: 20),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
      ),
    );
  }
}