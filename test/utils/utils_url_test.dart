import 'package:aleteo_arquetipo/utils/utils_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validateUrl should', () {
    test('return true for a valid https URL', () {
      expect(UtilUrl.validateUrl('https://www.example.com'), true);
    });

    test('return true for a valid http URL', () {
      expect(UtilUrl.validateUrl('http://www.example.com'), true);
    });

    test('return true for a valid URL without http/https', () {
      expect(UtilUrl.validateUrl('www.example.com'), false);
    });

    test('return false for an invalid URL', () {
      expect(UtilUrl.validateUrl('example.com'), false);
    });

    test('return false for an empty URL', () {
      expect(UtilUrl.validateUrl(''), false);
    });
  });
}
