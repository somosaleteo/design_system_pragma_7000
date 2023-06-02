part of pragma_app.modules.auth.providers;

class GoogleSignInProvider implements AuthenticationProviderInterface {
  late GoogleSignIn googleSignIn;

  GoogleSignInProvider() {
    googleSignIn = GoogleSignIn(
      scopes: [
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/classroom.rosters",
        "https://www.googleapis.com/auth/classroom.courses.readonly",
        "https://www.googleapis.com/auth/classroom.topics.readonly",
        "https://www.googleapis.com/auth/classroom.courseworkmaterials.readonly",
        "https://www.googleapis.com/auth/script.external_request",
        "https://www.googleapis.com/auth/classroom.coursework.students.readonly",
        "https://www.googleapis.com/auth/classroom.coursework.me.readonly"
      ],
    );
  }

  @override
  Future<Map<String, dynamic>> logIn() async {
    final GoogleSignInAccount? userGoogle = await googleSignIn.signIn();
    return _userGoogleToMap(userGoogle);
  }

  @override
  Future<Map<String, dynamic>> logOut() async {
    final userGoogle = await googleSignIn.disconnect();
    return _userGoogleToMap(userGoogle);
  }

  @override
  Future<Map<String, dynamic>> logInSilently() async {
    final userGoogle = await googleSignIn.signInSilently();
    return _userGoogleToMap(userGoogle);
  }

  Future<Map<String, dynamic>> _userGoogleToMap(
    GoogleSignInAccount? userGoogle,
  ) async {
    if (userGoogle != null) {
      final authenticationData = await userGoogle.authentication;
      return {
        'email': userGoogle.email,
        'name': userGoogle.displayName ?? '',
        'urlPhoto': userGoogle.photoUrl ?? '',
        'accessToken': authenticationData.accessToken,
      };
    }
    return {};
  }
}
