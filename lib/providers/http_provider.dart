import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../blocs/navigator_bloc.dart';
import '../modules/show_case/blocs/show_case_bloc.dart';
import '../services/http_service.dart';
import '../utils/methods_enum.dart';

class HttpProvider {
  HttpProvider({
    required this.method,
    required this.url,
    required this.navigatorBloc,
    this.data,
    //required this.authBloc,
  });
  final Methods method;
  final Map<String, dynamic>? data;
  final String url;
  final NavigatorBloc navigatorBloc;

  Future<Map<String, dynamic>> launchUrl() async {
    final HttpService httpService = HttpService(
      method: method.toString().split('.')[1].toUpperCase(),
      body: data,
      url: url,
      headers: <String, String>{},
    );

    final http.StreamedResponse response = await httpService.launchUrl();

    final String responseData = await response.stream.bytesToString();
    if (response.statusCode == 302 &&
        response.reasonPhrase == 'Moved Temporarily') {
      navigatorBloc.pushNamed(ShowCaseBloc.name);
      return <String, dynamic>{'data': 'Información guardada correctamente'};
    }
    final Map<String, dynamic> responseDataJson =
        jsonDecode(responseData) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return <String, dynamic>{'data': responseDataJson['data']};
    }

    throw Exception('error al consultar la información');
  }
}
