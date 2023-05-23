import 'package:equatable/equatable.dart';

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
  @override
  List<Object?> get props => [];
}
