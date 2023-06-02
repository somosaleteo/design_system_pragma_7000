part of pragma_app.modules.data_base.config;

class DataBaseConfig {
  void initConfigModule() {
    blocCore.addBlocModule<DataBaseBloc>(
      DataBaseBloc.name,
      DataBaseBloc(
        //authBloc: blocCore.getBlocModule<AuthBloc>(AuthBloc.name),
        navigatorBloc:
            blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name),
      ),
    );
  }
}
