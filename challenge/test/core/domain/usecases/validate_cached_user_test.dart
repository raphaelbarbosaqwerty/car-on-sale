import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/services/auth_service_interface.dart';
import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

void main() {
  late final MockAuthService service;
  late final IValidateCachedUser validateCachedUser;
  const user = User(name: 'Raphael', email: 'raphael@test.com');

  setUpAll(() {
    service = MockAuthService();
    validateCachedUser = ValidateCachedUser(service);
  });

  group('ValidateCachedUser', () {
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
