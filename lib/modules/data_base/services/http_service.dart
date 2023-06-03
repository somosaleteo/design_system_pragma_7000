part of pragma_app.modules.data_base.services;

class HttpService {
  final Methods method;
  final Map<String, dynamic>? data;
  final String? accessToken;
  final NavigatorBloc navigatorBloc;
  //final AuthBloc authBloc;

  HttpService({
    this.data,
    required this.method,
    this.accessToken,
    required this.navigatorBloc,
    //required this.authBloc,
  }) {
    _verifyToken();
  }

  Future<Map<String, dynamic>> launchUrl() async {
    final httpProvider = HttpProvider(
      method: method.toString().split('.')[1].toUpperCase(),
      body: data,
      headers: {'Authorization': accessToken ?? ''},
    );

    final http.StreamedResponse response = await httpProvider.launchUrl();

    final responseData = await response.stream.bytesToString();
    final Map<String, dynamic> responseDataJson = jsonDecode(responseData);

    if (response.statusCode == 200) {
      return {'data': responseDataJson["response"]["result"]};
    }

    throw Exception('error al consultar la información');
  }

  bool _verifyToken() {
    if (accessToken == null && accessToken!.isEmpty) {}
    return true;
  }
}
