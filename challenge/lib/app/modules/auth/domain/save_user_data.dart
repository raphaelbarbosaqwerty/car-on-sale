import 'package:challenge/app/core/domain/errors/user_errors.dart';
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
    if (user.email.isEmpty || user.name.isEmpty) {
      throw EmptyCredentials("The Field shouldn't be empty");
    }
    return await authService.saveUser(user);
  }
}
