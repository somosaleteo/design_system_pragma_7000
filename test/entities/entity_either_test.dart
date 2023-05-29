import 'package:aleteo_arquetipo/entities/entity_either.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when', () {
    test('returns value of left function when Either is Left', () {
      // Arrange
      final Left<int, String> either = Left<int, String>(42);

      // Act
      final String result = either.when(
        (int l) => l.toString(),
        (String r) => r.toUpperCase(),
      );

      // Assert
      expect(result, '42');
    });

    test('returns value of right function when Either is Right', () {
      // Arrange
      final Right<int, String> either = Right<int, String>('hello world');

      // Act
      final String result = either.when(
        (int l) => l.toString(),
        (String r) => r.toUpperCase(),
      );

      // Assert
      expect(result, 'HELLO WORLD');
    });
  });
}
