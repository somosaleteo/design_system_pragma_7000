import 'dart:convert';

import 'package:http/http.dart' as http;

import '../providers/my_app_navigator_provider.dart';

class HttpService {

  HttpService({
    required this.method, required this.headers, required this.url, this.body,
  });
  final String method;
  final Map<String, dynamic>? body;
  final Map<String, String> headers;
  final String url;

  Future<http.StreamedResponse> launchUrl() async {
    final http.Request request = http.Request(method, Uri.parse(url));
    if (body != null) {
      request.body = jsonEncode(body);
    }
    request.headers.addAll(headers);
    try {
      final http.StreamedResponse response = await request.send();
      return response;
    } catch (e) {
      debugPrint('Fail to do http request $request $e');
      rethrow;
    }
  }
}
