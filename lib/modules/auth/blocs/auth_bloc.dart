part of pragma_app.modules.auth.blocs;

class AuthBloc extends BlocModule {
  static const String name = 'authBloc';
  late BlocGeneral<UserModel> _authBloc;

  AuthBloc(this._service) {
    _authBloc = BlocGeneral<UserModel>(
      UserModel(),
    );
  }

  /// refactorizando el servicio
  final AuthService _service;
  UserModel get user => _authBloc.value;
  bool get isUserSession => _isValidUser();

  void onInit(void Function(UserModel userModel) function) async {
    await onLogInSilently();
    _addFunctionToSessionStream(
      'redirectToHomePage',
      function,
    );
  }

  Future<void> onLogIn() async {
    _authBloc.value = await _service.logIn();
  }

  Future<void> onLogOut() async {
    _authBloc.value = await _service.logOut();
  }

  Future<void> onLogInSilently() async {
    _authBloc.value = await _service.logInSilently();
  }

  bool _isValidUser() {
    bool tmp = isValidEmail(user.email);
    return tmp;
  }

  void _addFunctionToSessionStream(
    String keyFunction,
    void Function(UserModel userModel) function,
  ) {
    _authBloc.addFunctionToProcessTValueOnStream(keyFunction, function);
  }

  final Widget _landingPage = const LoginPage();
  Widget get landingPage => _landingPage;
  late Widget _homePage;

  Widget getHomePage() {
    return isUserSession ? _homePage : _landingPage;
  }

  void setHomePage(Widget page) {
    _homePage = page;
  }

  @override
  FutureOr<void> dispose() {
    _authBloc.dispose();
  }
}
