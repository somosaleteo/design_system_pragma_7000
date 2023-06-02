part of pragma_app.modules.auth.interfaces;

abstract class AuthenticationProviderInterface {
  Future<Map<String, dynamic>> logOut();
  Future<Map<String, dynamic>> logIn();
  Future<Map<String, dynamic>> logInSilently();
}
