import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/services/auth_service.dart';
import 'package:challenge/app/utils/cos_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthService implements IAuthService {
  @override
  Future<User> getCachedUser() async {
    final userBox = await Hive.openBox(CosConstants.userBox);
    final String id = await userBox.get('unique_id', defaultValue: "");
    if (id.isEmpty) {
      throw UserNotFound();
    }

    return User(
      name: await userBox.get('name', defaultValue: ""),
      uniqueId: id,
    );
  }

  @override
  Future<bool> saveUser(User user) async {
    try {
      final userBox = await Hive.openBox(CosConstants.userBox);
      userBox.put('name', user.name);
      userBox.put('unique_id', user.uniqueId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
