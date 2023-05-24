import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';

abstract class IHomeService {
  Future<void> saveSuggestions(List<CarAdditionalInfo> cars);
  Future<List<CarAdditionalInfo>> getSuggestions();
  Future<void> saveCarInformation(CarInformation car);
  Future<CarInformation> getCarInformation();
}
