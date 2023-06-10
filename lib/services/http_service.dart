import 'dart:convert';
import '../providers/my_app_navigator_provider.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String method;
  final Map<String, dynamic>? body;
  final Map<String, String> headers;
  final String url;

  HttpService({
    this.body,
    required this.method,
    required this.headers,
    required this.url
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
