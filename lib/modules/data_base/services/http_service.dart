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
    errorHandlingService = ErrorHandlingService(
      navigatorBloc: navigatorBloc,
      //authBloc: authBloc,
    );
  }

  late ErrorHandlingService errorHandlingService;

  Future<Map<String, dynamic>> launchUrl() async {
    final httpProvider = HttpProvider(
        method: method.toString().split('.')[1].toUpperCase(),
        body: data,
        headers: {'Authorization': accessToken ?? ''});

    final http.StreamedResponse response = await httpProvider.launchUrl();

    final responseData = await response.stream.bytesToString();
    final Map<String, dynamic> responseDataJson = jsonDecode(responseData);

    if (response.statusCode == 200) {
      print("Response Data Json");
      print(responseDataJson);
      if (responseDataJson.containsKey('error')) {
        final dataException =
            errorHandlingService.launchAlertError(responseDataJson['error']);
        debugPrint(responseDataJson.toString());

        throw dataException;
      }

      if (responseDataJson["response"]["result"]["error"] != null) {
        final dataException = errorHandlingService
            .launchAlertError(responseDataJson['response']['result']['error']);
        debugPrint(responseDataJson.toString());

        throw dataException;
      }

      return {'data': responseDataJson["response"]["result"]["data"]};
    }

    debugPrint(responseDataJson.toString());
    final dataException =
        errorHandlingService.launchAlertError(responseDataJson["error"]);
    throw dataException;
  }

  bool _verifyToken() {
    if (accessToken == null && accessToken!.isEmpty) {
      errorHandlingService.launchAlertError({"code": 401});
    }
    return true;
  }
}
