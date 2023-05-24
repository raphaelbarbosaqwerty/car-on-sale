import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserErrors', () {
    test('should return correct message for UserNotFound', () {
      final failure = UserNotFound('UserNotFound');
      expect(failure.toString(), 'Failure(message: UserNotFound)');
    });

    test('should return correct message for UnableToClearUserCredentials', () {
      final failure =
          UnableToClearUserCredentials('UnableToClearUserCredentials');
      expect(
          failure.toString(), 'Failure(message: UnableToClearUserCredentials)');
    });

    test('should return correct message for EmptyCredentials', () {
      final failure = EmptyCredentials('EmptyCredentials');
      expect(failure.toString(), 'Failure(message: EmptyCredentials)');
    });
  });
}
