import 'dart:async';

import '../entities/entity_bloc.dart';
import '../providers/http_provider.dart';
import '../utils/methods_enum.dart';
import 'navigator_bloc.dart';

class BlocHttp extends BlocModule {
  BlocHttp({
    required this.navigatorBloc,
  }) {
    accessToken = '';
  }
  static String name = 'blocHttp';

  final NavigatorBloc navigatorBloc;

  late String accessToken;

  Future<Map<String, dynamic>> create({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final HttpProvider httpService = HttpProvider(
      method: Methods.post,
      url: url,
      data: body,
      navigatorBloc: navigatorBloc,
    );
    try {
      return await httpService.launchUrl();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> read({
    required String url,
  }) async {
    final HttpProvider httpService = HttpProvider(
      method: Methods.get,
      url: url,
      navigatorBloc: navigatorBloc,
    );
    final Map<String, dynamic> response = await httpService.launchUrl();
    return response;
  }

  update() {}
  delete() {}

  bool hasDataError(Map<String, dynamic> data) {
    final bool isMap =
        data['data'].runtimeType.toString() == '_Map<String, dynamic>';
    return isMap && data['data'].containsKey('error') as bool;
  }

  @override
  FutureOr<void> dispose() {}
}
