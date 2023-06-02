part of pragma_app.modules.auth.services;

class AuthService {
  AuthService({
    required this.authenticationProvider,
  });

  final AuthenticationProviderInterface authenticationProvider;

  Future<UserModel> logIn() async {
    final responseProvider = await authenticationProvider.logIn();
    return _mapToUserModel(responseProvider);
  }

  Future<UserModel> logOut() async {
    final responseProvider = await authenticationProvider.logOut();
    return _mapToUserModel(responseProvider);
  }

  Future<UserModel> logInSilently() async {
    final responseProvider = await authenticationProvider.logInSilently();
    return _mapToUserModel(responseProvider);
  }

  UserModel _mapToUserModel(Map<String, dynamic> responseProvider) {
    UserModel userModel = UserModel();
    if (responseProvider.isNotEmpty) {
      userModel = userModel.copyWith(
        email: responseProvider['email'] ?? '',
        displayName: responseProvider['name'] ?? '',
        urlImg: responseProvider['urlPhoto'] ?? '',
        newAccessToken: responseProvider['accessToken'] ?? '',
      );
    }
    return userModel;
  }
}
