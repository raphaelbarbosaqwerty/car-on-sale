import 'package:challenge/app/core/domain/services/auth_service.dart';
import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:challenge/app/core/infra/services/auth_service.dart';
import 'package:challenge/app/modules/splash/presenter/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;
void setupLocator() {
  locator.registerSingleton<IAuthService>(AuthService());
  locator.registerSingleton<IValidateCachedUser>(ValidateCachedUser(
    locator.get(),
  ));
  locator.registerSingleton<SplashCubit>(SplashCubit(
    locator.get(),
  ));
}
