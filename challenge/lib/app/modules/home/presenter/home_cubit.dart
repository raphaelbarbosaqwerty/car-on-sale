import 'package:challenge/app/modules/auth/presenter/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoadingState());

  Future<void> checkInformations() async {}
}
