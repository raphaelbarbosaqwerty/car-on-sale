import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/errors/home_errors.dart';
import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:challenge/app/modules/home/domain/services/home_service_interface.dart';
import 'package:challenge/app/modules/home/domain/usecases/search_car_by_vin_number.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements IHomeRepository {}

class MockHomeService extends Mock implements IHomeService {}

void main() {
  late String vin;
  late IHomeService service;
  late CarInformation carInformation;
  late MockHomeRepository repository;
  late ISearchCarByVinNumber searchCarByVinNumber;

  setUpAll(() {
    service = MockHomeService();
    repository = MockHomeRepository();
    searchCarByVinNumber = SearchCarByVinNumber(repository, service);
    vin = "DE003-018601450020008";
    carInformation = CarInformation(
      externalId: vin,
    );
  });

  group('SearchCarByVinNumber', () {
    test('should return CarInformation if data exist', () async {
      when(() => repository.searchCarByVin(vin))
          .thenAnswer((_) async => (carInformation, <CarAdditionalInfo>[]));
      final response = await searchCarByVinNumber(vin);
      expect(response, isA<CarInformation>());
    });

    test('should return an Exception when VinCode is empty', () async {
      when(() => repository.searchCarByVin("")).thenThrow(VinCodeEmpty());
      expect(() async => await searchCarByVinNumber(""),
          throwsA(isA<VinCodeEmpty>()));
    });
  });
}
