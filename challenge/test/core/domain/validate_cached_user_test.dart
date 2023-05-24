import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/services/auth_service_interface.dart';
import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// create a mock implementation of the IAuthService interface
class MockAuthService extends Mock implements IAuthService {}

void main() {
  group('ValidateCachedUser', () {
    late MockAuthService service;
    late IValidateCachedUser validateCachedUser;
    final user = User(name: 'John Doe', email: 'john.doe@example.com');

    setUpAll(() {
      service = MockAuthService();
      validateCachedUser = ValidateCachedUser(service);
    });

    test('should return true if has the user on cache', () async {
      when(() => service.getCachedUser()).thenAnswer((_) async => user);
      final response = await validateCachedUser();
      expect(response, true);
    });

    test('should return an Exception if user not found', () async {
      when(() => service.getCachedUser()).thenThrow(UserNotFound());
      expect(
        () async => await validateCachedUser(),
        throwsA(isA<UserNotFound>()),
      );
    });
  });
}
