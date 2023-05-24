import 'package:challenge/app/core/domain/models/api_error.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  final CarInformation carInformation;

  HomeSuccessState(this.carInformation);

  @override
  List<Object?> get props => [
        carInformation,
      ];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState([
    this.message = "",
  ]);

  @override
  List<Object?> get props => [
        message,
      ];
}

class HomeErrorWithExtraState extends HomeState {
  final String message;
  final ApiError? apiError;

  HomeErrorWithExtraState([
    this.message = "",
    this.apiError,
  ]);

  @override
  List<Object?> get props => [
        message,
        apiError,
      ];
}
