import 'package:challenge/app/core/domain/errors/generic_errors.dart';
import 'package:challenge/app/modules/home/domain/usecases/search_car_by_vin_number.dart';
import 'package:challenge/app/modules/home/presenter/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final ISearchCarByVinNumber searchCarByVinNumber;

  HomeCubit(this.searchCarByVinNumber) : super(HomeLoadingState());

  Future<void> searchByVin(String vin) async {
    searchCarByVinNumber(vin).then((value) {
      emit(HomeSuccessState(value));
    }).onError((Failure error, stackTrace) {
      emit(HomeErrorState(error.message));
    });
  }
}
