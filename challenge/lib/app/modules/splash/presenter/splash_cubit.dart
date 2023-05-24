import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:challenge/app/modules/splash/presenter/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final IValidateCachedUser validateCachedUser;

  SplashCubit(this.validateCachedUser) : super(SplashLoadingState());

  Future<void> validateCache() async {
    validateCachedUser().then((isCached) {
      if (isCached) {
        emit(SplashCacheFilledState());
      } else {
        emit(SplashCacheEmptyState());
      }
    }).onError((error, stackTrace) {
      SplashCacheEmptyState();
    });
  }
}
