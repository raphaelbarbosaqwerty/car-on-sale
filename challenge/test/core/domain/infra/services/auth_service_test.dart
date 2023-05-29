import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/infra/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  late final AuthService authService;
  const user = User(name: 'Raphael', email: 'raphael@test.com');

  setUpAll(() async {
    await setUpTestHive();
    authService = AuthService();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  group('AuthService', () {
    test('should save and return user without issues', () async {
      final saveResponse = await authService.saveUser(user);
      expect(saveResponse, true);
      final getResponse = await authService.getCachedUser();
      expect(getResponse, isA<User>());
    });

    test('should return an UserNotFound if user not found', () async {
      expect(
        () async => await authService.getCachedUser(),
        throwsA(isA<UserNotFound>()),
      );
    });
  });
}
