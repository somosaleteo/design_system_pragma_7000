import 'dart:async';

import 'package:flutter/material.dart';

import '../entities/entity_bloc.dart';

class UserNotificationsBloc extends BlocModule {
  UserNotificationsBloc();
  static const String name = 'userNotificationsBloc';
  final BlocGeneral<String> _userAlertNotificationsBloc =
      BlocGeneral<String>('');
  final BlocGeneral<String> _userSnackBarNotificationsBloc =
      BlocGeneral<String>('');

  void showGeneralAlert(BuildContext context, String msg) {
    try {
      showAlert(context, Text(msg));
    } catch (e) {
      debugPrint('Imposible Ejecutar el alerta del usuario');
    }
  }

  void showGeneralSsnackBar(
    BuildContext context,
    String msg,
  ) {
    try {
      final SnackBar snackBar = SnackBar(
        content: Text(msg),
      );
      showSnackBar(context, snackBar);
    } catch (e) {
      debugPrint('Imposible presentar el Snack Bar');
    }
  }

  void showSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showAlert(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: widget,
      ),
    );
  }

  @override
  FutureOr<void> dispose() {
    _userAlertNotificationsBloc.dispose();
    _userSnackBarNotificationsBloc.dispose();
  }
}
