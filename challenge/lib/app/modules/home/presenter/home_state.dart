import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthCacheFilledState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthCacheEmptyState extends AuthState {
  @override
  List<Object?> get props => [];
}
