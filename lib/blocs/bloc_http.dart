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

  void update() {}
  void delete() {}

  bool hasDataError(Map<String, dynamic> data) {
    if (data['data'] is Map<String, dynamic>) {
      final Map<String, dynamic> dataMap = data['data'] as Map<String, dynamic>;
      return dataMap.containsKey('error');
    } else {
      return false;
    }
  }

  @override
  FutureOr<void> dispose() {}
}
