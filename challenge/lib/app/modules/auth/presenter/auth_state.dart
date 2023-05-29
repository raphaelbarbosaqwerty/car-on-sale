import 'package:equatable/equatable.dart';
// coverage:ignore-file

abstract class AuthState extends Equatable {}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);

  @override
  List<Object?> get props => [];
}
