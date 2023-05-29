import 'package:challenge/app/core/domain/errors/api_errors.dart';
import 'package:challenge/app/core/domain/errors/generic_errors.dart';
import 'package:challenge/app/modules/home/domain/usecases/search_car_by_vin_number.dart';
import 'package:challenge/app/modules/home/presenter/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final ISearchCarByVinNumber searchCarByVinNumber;

  HomeCubit(this.searchCarByVinNumber) : super(HomeLoadingState());

  Future<void> searchByVin(String vin) async {
    try {
      emit(HomeLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      final response = await searchCarByVinNumber(vin);
      emit(HomeSuccessState(
        response.$1,
        response.$2,
      ));
    } on InternalApiError catch (error) {
      emit(HomeErrorWithExtraState(error.message, error.extraError));
    } on Failure catch (error) {
      emit(HomeErrorState(error.message));
    } catch (e) {
      emit(HomeErrorState("Please contact support."));
    }
  }
}
