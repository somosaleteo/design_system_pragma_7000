part of pragma_app.modules.data_base.config;

class DataBaseConfig {
  void initConfigModule() {
    blocCore.addBlocModule<DataBaseBloc>(
      DataBaseBloc.name,
      DataBaseBloc(
        navigatorBloc:
          blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name),
      ),
    );
  }
}
