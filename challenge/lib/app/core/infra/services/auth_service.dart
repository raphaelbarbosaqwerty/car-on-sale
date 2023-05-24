import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/services/auth_service_interface.dart';
import 'package:challenge/app/utils/cos_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthService implements IAuthService {
  @override
  Future<User> getCachedUser() async {
    try {
      final userBox = await _getUserBox();
      final String id = await userBox.get('unique_id', defaultValue: "");
      if (id.isEmpty) {
        throw UserNotFound();
      }

      return User(
        name: await userBox.get('name', defaultValue: ""),
        email: id,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveUser(User user) async {
    try {
      final userBox = await _getUserBox();
      userBox.put('name', user.name);
      userBox.put('unique_id', user.email);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final userBox = await _getUserBox();
      userBox.clear();
    } catch (e) {
      throw UnableToClearUserCredentials();
    }
  }

  Future<Box> _getUserBox() async {
    return await Hive.openBox(CosConstants.userBox);
  }
}
