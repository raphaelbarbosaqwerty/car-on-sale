import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';

abstract class IHomeRepository {
  Future<(CarInformation, List<CarAdditionalInfo>)> searchCarByVin(String vin);
}
