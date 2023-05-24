import 'package:challenge/app/core/domain/models/user.dart';

abstract class IAuthService {
  Future<User> getCachedUser();
  Future<bool> saveUser(User user);
  Future<void> logout();
}
