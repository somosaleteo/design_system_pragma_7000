import 'dart:async';
import '../entities/entity_bloc.dart';
import '../providers/http_provider.dart';
import '../utils/methods_enum.dart';
import 'navigator_bloc.dart';

class BlocHttp extends BlocModule {
  static String name = 'blocHttp';

  final NavigatorBloc navigatorBloc;

  late String accessToken;

  BlocHttp({
    required this.navigatorBloc,
  }) {
    accessToken =
        'Bearer ya29.a0AWY7CkldB6w-64Yc8AdOk48GO7wsLLMwnLZDF1g9acjY00-5x2B0ohiKcCk9TOLS0Gpfg97ZgACS9tSeIS-IFNwZUk-eLQ1Bt9wGQSeawhlymYeRet_7chOEOx1K0vIXily0Y9-imBDAAY4nz60emd33YAhDDwaCgYKAYwSARESFQG1tDrpZGN1DHNqbcizZM_wvc_zGw0165';
  }

  Future<Map<String, dynamic>> create({
    required String module,
    required List parameters,
  }) async {
    final data = {'function': module, 'parameters': parameters};

    final httpService = HttpProvider(
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

    final httpService = HttpProvider(
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
