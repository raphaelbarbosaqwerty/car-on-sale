import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/usecases/do_logout.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final IDoLogout doLogout;

  LogoutCubit(this.doLogout) : super(LogoutInitialState());

  Future<void> logout() async {
    emit(LogoutLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    doLogout().whenComplete(() {
      emit(LogoutSuccessState());
    }).onError((error, stackTrace) {
      if (error is UnableToClearUserCredentials) {
        emit(LogoutErrorState());
      }
    });
  }
}
