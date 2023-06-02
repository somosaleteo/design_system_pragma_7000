part of pragma_app.modules.data_base.providers;

class HttpProvider {
  final String method;
  final Map<String, dynamic>? body;
  final Map<String, String> headers;
  final String url =
      "https://script.googleapis.com/v1/scripts/AKfycby3XDh8baR6sWzHJQhacr-bge-RkkxMyswsT8U0DlW5:run";

  HttpProvider({
    this.body,
    required this.method,
    required this.headers,
  });

  Future<http.StreamedResponse> launchUrl() async {
    var request = http.Request(method, Uri.parse(url));
    if (body != null) {
      request.body = jsonEncode(body);
    }
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      return response;
    } catch (e) {
      debugPrint("Fail to do http request $request $e");
      rethrow;
    }
  }
}
