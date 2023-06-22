import 'package:flutter/material.dart';

class LibraryLayoutDesignSystem extends StatelessWidget {
  const LibraryLayoutDesignSystem({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF330072);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Empieza a usar la librería',
          style: TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.w700,
            color: mainColor,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'La librería es  proyecto publicado con varios componentes. Al ser publicado como librería podrá ser reutilizado en otros proyectos y así es como varios proyectos dentro de una misma marca tienen el mismo lenguaje de comunicación.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: mainColor,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          '¿Dónde se encuentra?',
          style: TextStyle(
            color: mainColor,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'En Figma, para tener acceso contacta al líder del Chapter UI, te guiará para ajustar tu espacio de trabajo y junto con el equipo del Design System solucionarás dudas o preguntas que surjan. Así comenzarás a crear soluciones grandiosas y a resolver con la potencia de Pragma.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: mainColor,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          width: 627,
          height: 106,
          decoration: BoxDecoration(
            color: const Color(0xff6429CD).withOpacity(0.1),
            border: Border.all(
              color: const Color(0xff6429CD),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(23, 23, 12, 53),
                child: const Icon(Icons.error_outline),
              ),
              const Expanded(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae nulla non lacus malesuada molestie. Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: mainColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Image.asset('assets/image_1.png'),
        const SizedBox(height: 30),
        const Text(
          'Lorem ipsum1',
          style: TextStyle(
            color: mainColor,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'En Figma, para tener acceso contacta al líder del Chapter UI, te guiará para ajustar tu espacio de trabajo y junto con el equipo del Design System solucionarás dudas o preguntas que surjan. Así comenzarás a crear soluciones grandiosas y a resolver con la potencia de Pragma.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: mainColor,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset('assets/image_2.png'),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: 15,
              height: 3,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                height: 7,
              ),
            ),
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: 15,
              height: 3,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
