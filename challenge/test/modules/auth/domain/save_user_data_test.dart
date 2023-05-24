import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/services/auth_service_interface.dart';
import 'package:challenge/app/modules/auth/domain/save_user_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// create a mock implementation of the IAuthService interface
class MockAuthService extends Mock implements IAuthService {}

void main() {
  group('SaveUserData', () {
    late MockAuthService service;
    late ISaveUserData saveUserData;
    final user = User(name: 'John Doe', email: 'john.doe@example.com');

    setUpAll(() {
      service = MockAuthService();
      saveUserData = SaveUserData(service);
    });

    test('should return true if the user is saved', () async {
      when(() => service.saveUser(user)).thenAnswer((_) async => true);
      final response = await saveUserData(user);
      expect(response, true);
    });

    test('should return an Exception when credentials are empty', () async {
      final user = User(name: '', email: '');
      when(() => service.saveUser(user)).thenThrow(EmptyCredentials());
      expect(() async => await saveUserData(user),
          throwsA(isA<EmptyCredentials>()));
    });
  });
}
