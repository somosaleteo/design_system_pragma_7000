part of pragma_app.modules.data_base.blocs;

class DataBaseBloc extends BlocModule {
  static String name = 'dataBaseBlocName';

  //final AuthBloc authBloc;
  final NavigatorBloc navigatorBloc;

  late String accessToken;

  DataBaseBloc({
    //required this.authBloc,
    required this.navigatorBloc,
  }) {
    //accessToken = 'Bearer ${authBloc.user.accessToken}';
    accessToken =
        'Bearer ya29.a0AWY7CkneX57fn9nVAQUlPkVfV8_RgT7Hl7lgFTYa19qrQyHv8q9P7vQgEL_p_1MCXrORdG5aLN2m50u1wk0wX4addJOCSCaGJAYldJAHNQeAtOficUTLR63VdV-jrJxTOfld_bzouc0BR4euwsZKC8JviGTuBAaCgYKAdISARESFQG1tDrp11fe_98sHx_IfeLderMinA0165';
  }

  Future<Map<String, dynamic>> create({
    required String module,
    required List parameters,
  }) async {
    final data = {'function': module, 'parameters': parameters};

    final httpService = HttpService(
      method: Methods.post,
      accessToken: accessToken,
      data: data,
      //authBloc: authBloc,
      navigatorBloc: navigatorBloc,
    );
    try {
      return await httpService.launchUrl();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> read({
    required String module,
    required List parameters,
  }) async {
    final data = {'function': module, 'parameters': parameters};

    final httpService = HttpService(
      method: Methods.post,
      accessToken: accessToken,
      data: data,
      //authBloc: authBloc,
      navigatorBloc: navigatorBloc,
    );
    return await httpService.launchUrl();
  }

  update() {}
  delete() {}

  bool hasDataError(Map<String, dynamic> data) {
    final isMap =
        data['data'].runtimeType.toString() == '_Map<String, dynamic>';
    return isMap && data['data'].containsKey('error');
  }

  @override
  FutureOr<void> dispose() {}
}
