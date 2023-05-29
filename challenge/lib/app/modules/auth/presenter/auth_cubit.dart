import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/modules/auth/domain/usecases/save_user_data.dart';
import 'package:challenge/app/modules/auth/presenter/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final ISaveUserData saveUserData;

  AuthCubit(this.saveUserData) : super(AuthInitialState());

  Future<void> save(User user) async {
    try {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      final response = await saveUserData(user);
      if (response) {
        emit(AuthSuccessState());
      }
      // EmptyCredentials
    } on EmptyCredentials catch (error) {
      emit(AuthErrorState(error.message));
    } catch (e) {
      emit(AuthErrorState("Please contact support."));
    }
  }
}
