import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/services/auth_service_interface.dart';
import 'package:challenge/app/core/domain/usecases/do_logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

void main() {
  late final MockAuthService service;
  late final IDoLogout doLogout;

  setUpAll(() {
    service = MockAuthService();
    doLogout = DoLogout(service);
  });

  group('DoLogout', () {
    test('should return true if user can logout', () async {
      when(() => service.logout()).thenAnswer((_) async => true);
      final response = await doLogout();
      expect(response, true);
    });

    test(
        'should return an UnableToClearUserCredentials if is not possible to clear user credentials',
        () async {
      when(() => service.logout()).thenThrow(UnableToClearUserCredentials());
      expect(
        () async => await doLogout(),
        throwsA(isA<UnableToClearUserCredentials>()),
      );
    });
  });
}
