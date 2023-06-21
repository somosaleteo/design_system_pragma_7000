import 'dart:convert';

import '../../../blocs/navigator_bloc.dart';
import '../modules/show_case/blocs/show_case_bloc.dart';
import '../services/http_service.dart';
import 'package:http/http.dart' as http;
import '../utils/methods_enum.dart';

class HttpProvider {
  final Methods method;
  final Map<String, dynamic>? data;
  final String url;
  final NavigatorBloc navigatorBloc;

  HttpProvider({
    this.data,
    required this.method,
    required this.url,
    required this.navigatorBloc,
    //required this.authBloc,
  });

  Future<Map<String, dynamic>> launchUrl() async {
    final httpService = HttpService(
      method: method.toString().split('.')[1].toUpperCase(),
      body: data,
      url: url,
      headers: {},
    );

    final http.StreamedResponse response = await httpService.launchUrl();

    final responseData = await response.stream.bytesToString();
    if (response.statusCode == 302 &&
        response.reasonPhrase == 'Moved Temporarily') {
      navigatorBloc.pushNamed(ShowCaseBloc.name);
      return {'data': "Información guardada correctamente"};
    }
    final Map<String, dynamic> responseDataJson = jsonDecode(responseData);

    if (response.statusCode == 200) {
      return {'data': responseDataJson["data"]};
    }

    throw Exception('error al consultar la información');
  }
}
