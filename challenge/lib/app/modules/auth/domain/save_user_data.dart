import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/services/auth_service_interface.dart';

abstract class ISaveUserData {
  Future<bool> call(User user);
}

class SaveUserData implements ISaveUserData {
  final IAuthService authService;

  SaveUserData(this.authService);

  @override
  Future<bool> call(User user) async {
    return await authService.saveUser(user);
  }
}
