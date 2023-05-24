import 'package:challenge/app/core/domain/errors/generic_errors.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFailure extends Failure {
  MockFailure(super.message);
}

void main() {
  group('Failure', () {
    test('should return correct message', () {
      final failure = MockFailure('Error');
      expect(failure.toString(), 'Failure(message: Error)');
    });
  });
}
