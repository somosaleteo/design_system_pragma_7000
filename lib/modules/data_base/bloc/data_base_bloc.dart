part of pragma_app.modules.data_base.blocs;

class DataBaseBloc extends BlocModule {
  static String name = 'dataBaseBlocName';

  final NavigatorBloc navigatorBloc;

  late String accessToken;

  DataBaseBloc({
    required this.navigatorBloc,
  }) {
    accessToken =
        'Bearer ya29.a0AWY7Ckk3XsfTuWr0RUn_MfoOBHavgZ_CmouDUF1rm22z44roEV1_JN8cejxVAciJDtzOqQ1zJROSaBxcaPnMyWlOlYUu8F1zNOnCnzHatmIESjx8tY7tUe65ANXo0xvYBpYPne1km0fXQ2fP0MgMD1nkD2YGkwaCgYKAXcSARMSFQG1tDrpNm0wzyYRbi9wimKKmDvacg0165';
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
