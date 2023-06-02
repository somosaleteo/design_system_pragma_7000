import '../../../app_config.dart';
import '../blocs/blocs.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class AuthBlocConfig {
  void initConfigModule() {
    blocCore.addBlocModule<AuthBloc>(
      AuthBloc.name,
      AuthBloc(
        AuthService(
          authenticationProvider: GoogleSignInProvider(),
        ),
      ),
    );
  }
}
