import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {}

class SplashLoadingState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashCacheFilledState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashCacheEmptyState extends SplashState {
  @override
  List<Object?> get props => [];
}
