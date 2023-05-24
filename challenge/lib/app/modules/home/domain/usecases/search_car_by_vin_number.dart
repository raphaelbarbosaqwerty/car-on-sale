import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/errors/home_errors.dart';
import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';

abstract class ISearchCarByVinNumber {
  Future<CarInformation> call(String vin);
}

class SearchCarByVinNumber implements ISearchCarByVinNumber {
  final IHomeRepository repository;

  SearchCarByVinNumber(this.repository);

  @override
  Future<CarInformation> call(String vin) async {
    if (vin.isEmpty) {
      throw VinCodeEmpty("VIN Number can't be empty");
    }
    final response = await repository.searchCarByVin(vin);
    return response.$1;
  }
}
