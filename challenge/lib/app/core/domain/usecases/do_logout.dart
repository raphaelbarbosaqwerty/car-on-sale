import 'package:challenge/app/core/domain/services/auth_service_interface.dart';

abstract class IDoLogout {
  Future<bool> call();
}

class DoLogout implements IDoLogout {
  final IAuthService service;

  DoLogout(this.service);

  @override
  Future<bool> call() async {
    return await service.logout();
  }
}
