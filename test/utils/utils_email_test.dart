import 'package:aleteo_arquetipo/utils/utils_email.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Valid email address', () {
    const String email = 'john.doe@example.com';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, true);
  });

  test('Invalid email address - no @ symbol', () {
    const String email = 'johndoe.example.com';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });

  test('Invalid email address - multiple @ symbols', () {
    const String email = 'john@doe@example.com';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });

  test('Invalid email address - leading dot', () {
    const String email = '.johndoe@example.com';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });

  test('Invalid email address - trailing dot', () {
    const String email = 'johndoe@example.com.';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });

  test('Invalid email address - leading dash', () {
    const String email = '-johndoe@example.com';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });

  test('Invalid email address - trailing dash', () {
    const String email = 'johndoe@example.com-';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });

  test('Invalid email address - consecutive dots', () {
    const String email = 'john..doe@example.com';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });

  test('Invalid email address - consecutive dashes', () {
    const String email = 'john--doe@example.com';
    final bool result = UtilEmail.validateEmail(email);
    expect(result, false);
  });
}
