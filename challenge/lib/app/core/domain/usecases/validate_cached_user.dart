import 'package:challenge/app/core/domain/services/auth_service_interface.dart';

abstract class IValidateCachedUser {
  Future<bool> call();
}

class ValidateCachedUser implements IValidateCachedUser {
  final IAuthService service;

  ValidateCachedUser(this.service);

  @override
  Future<bool> call() async {
    final response = await service.getCachedUser();
    await Future.delayed(const Duration(seconds: 1));
    if (response.uniqueId.isNotEmpty) {
      return true;
    }
    return false;
  }
}
