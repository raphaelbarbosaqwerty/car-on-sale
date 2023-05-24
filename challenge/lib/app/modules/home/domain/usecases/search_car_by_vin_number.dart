import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';

abstract class ISearchCarByVinNumber {
  Future<void> call(String vin);
}

class SearchCarByVinNumber implements ISearchCarByVinNumber {
  final IHomeRepository repository;

  SearchCarByVinNumber(this.repository);

  @override
  Future<void> call(String vin) async {
    return await repository.searchCarByVin(vin);
  }
}
