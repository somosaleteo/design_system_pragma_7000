import 'package:flutter/material.dart';

import '../../blocs/bloc_user_notifications.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final UserNotificationsBloc userNotificationsBloc = UserNotificationsBloc();
    return MaterialApp(
      home: Material(
        child: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<void>.delayed(const Duration(milliseconds: 1000), () {
                userNotificationsBloc.showGeneralAlert(
                  context,
                  'Esto es una prueba',
                );
              });

              return const Center(
                child: Text('Hola'),
              );
            },
          ),
        ),
      ),
    );
  }
}
