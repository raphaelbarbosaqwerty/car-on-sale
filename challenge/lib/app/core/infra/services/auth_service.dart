import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/services/auth_service.dart';

class AuthService implements IAuthService {
  @override
  Future<User> getCachedUser() async {
    return User(
      name: "",
      uniqueIdentifier: "",
    );
  }

  @override
  Future<bool> saveUser(User user) {
    // TODO: implement saveUserInformation
    throw UnimplementedError();
  }
}
