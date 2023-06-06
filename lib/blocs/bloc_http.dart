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
        'Bearer ya29.a0AWY7CkkbqU2YwlzM5pwALk9_24HYJAi1aBeCO35egRLXYbrMKN4zgs6OZo1wtKcN1JjkUz8PW-zNFkEnH6Ong7IINMRCQTwMB7PPZN6CBjGAEdnNE0loSbfhS-Q1p6B_Lv57avAg47nbq_5f2VLwEQ2SbvRK4QaCgYKAaUSARESFQG1tDrp3W5AZBNSK-Hg3KyKY6i9gg0165';
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
