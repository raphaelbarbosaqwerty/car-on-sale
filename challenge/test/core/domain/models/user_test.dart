import 'package:challenge/app/core/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('should two users with same name and email should be equal', () {
      const user1 = User(name: 'Raphael', email: 'raphael@example.com');
      const user2 = User(name: 'Raphael', email: 'raphael@example.com');
      expect(user1, equals(user2));
    });

    test('should two users with different name/email should not be equal', () {
      const user1 = User(name: 'Raphael', email: 'raphael@example.com');
      const user2 = User(name: 'Ezequiel', email: 'ezequiel@example.com');
      expect(user1, isNot(equals(user2)));
    });

    test(
        'should two users with same name but different email should not be equal',
        () {
      const user1 = User(name: 'Raphael', email: 'raphael@example.com');
      const user2 = User(name: 'Raphael', email: 'ezequiel@example.com');
      expect(user1, isNot(equals(user2)));
    });

    test(
        'should two users with same email but different name should not be equal',
        () {
      const user1 = User(name: 'Raphael', email: 'raphael@example.com');
      const user2 = User(name: 'Ezequiel', email: 'ezequiel@example.com');
      expect(user1, isNot(equals(user2)));
    });
  });
}
