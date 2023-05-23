import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/modules/auth/domain/save_user_data.dart';
import 'package:challenge/app/modules/auth/presenter/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final ISaveUserData saveUserData;

  AuthCubit(this.saveUserData) : super(AuthInitialState());

  Future<void> save(User user) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    saveUserData(user).then(
      (saved) {
        if (saved) {
          emit(AuthSuccessState());
        }
      },
    ).onError(
      (error, stackTrace) {
        emit(AuthErrorState());
      },
    );
  }
}
