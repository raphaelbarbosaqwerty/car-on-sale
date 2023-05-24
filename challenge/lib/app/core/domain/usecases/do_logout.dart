import 'package:challenge/app/core/domain/services/auth_service_interface.dart';

abstract class IDoLogout {
  Future<void> call();
}

class DoLogout implements IDoLogout {
  final IAuthService service;

  DoLogout(this.service);

  @override
  Future<void> call() async {
    return await service.logout();
  }
}
