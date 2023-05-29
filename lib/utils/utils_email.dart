import '../entities/entity_util.dart';

class UtilEmail extends EntityUtil {
  static bool validateEmail(String emailAddress) {
    final RegExp regExp = RegExp(
      r'^(([^\s<>()[\]\\.,;:\-"@]+(\.[^\s<>()[\]\\.,;:\-"@]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    return regExp.hasMatch(emailAddress);
  }
}
