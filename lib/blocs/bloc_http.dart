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
        'Bearer ya29.a0AWY7Ckl9e6TvrqcNyp2z6uxq0sxrFd2YIwmH6JPkGrDO5c2BOEzpQAl6-wdsMIJIkftxDAE93u35IEENOxvAd_Bh_P60pUdcQlQaykdKE3CBysgjI5E6YE8S2iVrlYTG8b4rXLJd6tItQLZqqwTIInv6UrV3OQaCgYKAbISARESFQG1tDrpOzU-dz5VZI0WQJv_83e38A0165';
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
