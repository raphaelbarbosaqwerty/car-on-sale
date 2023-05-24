import 'package:challenge/app/core/domain/services/auth_service.dart';
import 'package:challenge/app/core/domain/usecases/do_logout.dart';
import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:challenge/app/core/infra/services/auth_service.dart';
import 'package:challenge/app/modules/auth/domain/save_user_data.dart';
import 'package:challenge/app/modules/auth/presenter/auth_cubit.dart';
import 'package:challenge/app/modules/home/presenter/home_cubit.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_cubit.dart';
import 'package:challenge/app/modules/splash/presenter/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;
void setupLocator() {
  locator
      .registerLazySingleton<ISaveUserData>(() => SaveUserData(locator.get()));
  locator.registerLazySingleton<IAuthService>(() => AuthService());
  locator.registerLazySingleton<HomeCubit>(() => HomeCubit());
  locator.registerLazySingleton<LogoutCubit>(() => LogoutCubit(locator.get()));
  locator.registerLazySingleton<IDoLogout>(() => DoLogout(locator.get()));
  locator.registerLazySingleton<IValidateCachedUser>(
    () => ValidateCachedUser(
      locator.get(),
    ),
  );
  locator.registerLazySingleton<SplashCubit>(
    () => SplashCubit(
      locator.get(),
    ),
  );
  locator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      locator.get(),
    ),
  );
}
