import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:challenge/app/modules/splash/presenter/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final IValidateCachedUser validateCachedUser;

  SplashCubit(this.validateCachedUser) : super(SplashLoadingState());

  Future<void> validateCache() async {
    try {
      emit(SplashLoadingState());
      final response = await validateCachedUser();
      if (response) {
        emit(SplashCacheFilledState());
      } else {
        emit(SplashCacheEmptyState());
      }
    } on UserNotFound {
      emit(SplashCacheEmptyState());
    } catch (e) {
      emit(SplashCacheEmptyState());
    }
  }
}
