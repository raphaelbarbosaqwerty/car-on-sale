import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/errors/home_errors.dart';
import 'package:challenge/app/modules/home/domain/services/home_service_interface.dart';
import 'package:challenge/app/utils/cos_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeService implements IHomeService {
  @override
  Future<void> saveSuggestions(List<CarAdditionalInfo> cars) async {
    try {
      final suggestionBox = await _getBox(CosConstants.carsSuggestion);
      final List<CarAdditionalInfo> response = await getSuggestions();
      if (response.isNotEmpty) {
        await suggestionBox.clear();
      }
      await suggestionBox.put(
        'suggestions',
        CarAdditionalInfo.toJsonList(cars),
      );
    } catch (e) {
      throw UnableToCacheSuggestions();
    }
  }

  @override
  Future<List<CarAdditionalInfo>> getSuggestions() async {
    try {
      final List<CarAdditionalInfo> ready = [];
      final suggestionBox = await _getBox(CosConstants.carsSuggestion);
      final List<dynamic> response = await suggestionBox.get(
        'suggestions',
        defaultValue: [],
      );

      if (ready.isEmpty) {
        return [];
      }

      return response.map((e) => CarAdditionalInfo.fromJson(e)).toList();
    } catch (e) {
      throw UnableToGetSuggestions();
    }
  }

  @override
  Future<void> saveCarInformation(CarInformation car) async {
    try {
      final carBox = await _getBox(CosConstants.carCached);
      final CarInformation response = await getCarInformation();
      if (response.externalId.isNotEmpty) {
        await carBox.clear();
      }
      await carBox.put(
        'car',
        car.toJson(),
      );
    } catch (e) {
      throw UnableToSaveCarInformation();
    }
  }

  @override
  Future<CarInformation> getCarInformation() async {
    try {
      final suggestionBox = await _getBox(CosConstants.carCached);
      final response = await suggestionBox.get(
        'car',
        defaultValue: Map<String, dynamic>,
      );

      if (response.isEmpty) {
        return const CarInformation();
      }

      return CarInformation.fromJson(Map.from(response));
    } catch (e) {
      return const CarInformation();
    }
  }

  Future<Box> _getBox(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    }
    return await Hive.openBox(name);
  }
}
