import 'package:aleteo_arquetipo/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ModelUser', () {
    const String name = 'John Doe';
    const String photoUrl = 'https://example.com/john-doe.jpg';

    test('copyWith() should return a new instance with updated values', () {
      const ModelUser user = ModelUser(name: name, photoUrl: photoUrl);
      final ModelUser updatedUser = user.copyWith(nameTmp: 'Jane Doe');
      expect(updatedUser.name, 'Jane Doe');
      expect(updatedUser.photoUrl, photoUrl);
    });

    test('toJson() should return a valid JSON object', () {
      const ModelUser user = ModelUser(name: name, photoUrl: photoUrl);
      final Map<String, dynamic> json = user.toJson();
      expect(json['name'], name);
      expect(json['photourl'], photoUrl);
    });

    test('equality check should work as expected', () {
      const ModelUser user1 = ModelUser(name: name, photoUrl: photoUrl);
      const ModelUser user2 = ModelUser(name: name, photoUrl: photoUrl);
      const ModelUser user3 = ModelUser(name: 'Jane Doe', photoUrl: photoUrl);
      expect(user1, user2);
      expect(user1.hashCode, user2.hashCode);
      expect(user1, isNot(user3));
      expect(user1.hashCode, isNot(user3.hashCode));
    });
  });
}
