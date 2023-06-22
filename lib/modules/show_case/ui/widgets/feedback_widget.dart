import 'package:flutter/material.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.mainColor,
  });

  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Feedback',
          style: TextStyle(
            color: mainColor,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: mainColor,
            ),
            children: const [
              TextSpan(
                  text:
                      'El design system es de todos y eres parte de la solución,',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text:
                    ' si identificas una oportunidad de mejora o un componente que no está en la librería siéntete libre de proponerlo.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary),
          ),
          onPressed: () {},
          child: const Text(
            'Enviar Feedback',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: mainColor,
            ),
            children: const [
              TextSpan(
                  text:
                      'Puedes contactar el equipo del Design System a través del correo si necesitas ayuda '),
              TextSpan(
                text: 'design.system@pragma.com.co',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
