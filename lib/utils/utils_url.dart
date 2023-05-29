import '../entities/entity_util.dart';

class UtilUrl extends EntityUtil {
  /// [validarteUrl] Validate web url
  /// Permite validar si una direccion web es o no valida
  static bool validateUrl(String urlAddress) {
    final RegExp regExp = RegExp(r'^https?://[\w\-]+(\.[\w\-]+)+[/#?]?.*$');
    return regExp.hasMatch(urlAddress);
  }
}
