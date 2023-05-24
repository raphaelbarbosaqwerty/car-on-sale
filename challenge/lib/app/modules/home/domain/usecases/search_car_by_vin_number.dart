import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/errors/home_errors.dart';
import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:challenge/app/modules/home/domain/services/home_service_interface.dart';

abstract class ISearchCarByVinNumber {
  Future<(CarInformation, List<CarAdditionalInfo>)> call(String vin);
}

class SearchCarByVinNumber implements ISearchCarByVinNumber {
  final IHomeRepository repository;
  final IHomeService service;

  SearchCarByVinNumber(
    this.repository,
    this.service,
  );

  @override
  Future<(CarInformation, List<CarAdditionalInfo>)> call(String vin) async {
    if (vin.isEmpty) {
      throw VinCodeEmpty("VIN Number can't be empty");
    }
    final response = await repository.searchCarByVin(vin);
    final car = response.$1;
    final suggestions = _orderBySimilarity(response.$2);

    // if (car.externalId.isEmpty && suggestions.isNotEmpty) {
    //   await service.saveSuggestions(suggestions);
    // }

    // if (car.externalId.isNotEmpty) {
    //   await service.saveCarInformation(car);
    // }

    return (car, suggestions);
  }

  /// Order By Similarity (Task 3: Bonus)
  List<CarAdditionalInfo> _orderBySimilarity(
      List<CarAdditionalInfo> suggestions) {
    suggestions.sort(
      (a, b) => b.similarity.compareTo(a.similarity),
    );
    return suggestions;
  }
}
