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
        'Bearer ya29.a0AWY7CkkrKJqTPd8zHPyq7ShbBuqPQ5VsUiR0QzXM-ovLBUvRsfDGSSTj6u1gLA5rrJg9I6z3OwKYVrdz15GzGM45M3S8MxeT0b6xdIKothZjskQcBmBkPZnYHybhykXMxFGRXC7AukHiXUNNDKZDyqIMZfzv5gaCgYKAbYSARASFQG1tDrplUtBKXim9BxDKDuYftymeQ0165';
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
