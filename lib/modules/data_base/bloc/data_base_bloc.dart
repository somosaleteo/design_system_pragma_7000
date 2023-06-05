part of pragma_app.modules.data_base.blocs;

class DataBaseBloc extends BlocModule {
  static String name = 'dataBaseBlocName';

  final NavigatorBloc navigatorBloc;

  late String accessToken;

  DataBaseBloc({
    required this.navigatorBloc,
  }) {
    accessToken =
        'Bearer ya29.a0AWY7Ckn5DXAjGPgboSaCTFR4zjk7m-jfSNMKOvw1OdCd3U1VadoYpFlqaS2BLcRgisvOipVOXd1ImPEbjz8COnhVMBs4c-ydFutbWxzHhWMjz30e2uYP68K1KgqjEo6R8CcQNfXMgqJV1eZtEgUqj-Lyzo20HAaCgYKAbwSARASFQG1tDrpc81Tl6PZktz8QDhJyCSlsQ0165';
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
