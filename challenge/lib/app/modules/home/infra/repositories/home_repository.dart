import 'dart:async';
import 'dart:convert';

import 'package:challenge/app/core/domain/errors/api_errors.dart';
import 'package:challenge/app/core/domain/models/api_error.dart';
import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:challenge/app/utils/cos_client.dart';
import 'package:http/http.dart';

class HomeRepository implements IHomeRepository {
  final BaseClient client;

  HomeRepository(this.client);

  @override
  Future<(CarInformation, List<CarAdditionalInfo>)> searchCarByVin(
      String vin) async {
    try {
      final response = await client.get(
        Uri.https('anyUrl'),
        headers: {
          CosChallenge.user: 'someUserId',
        },
      );

      if (response.statusCode == 200) {
        final carDecoded = CarInformation.fromJson(jsonDecode(response.body));
        return (carDecoded, <CarAdditionalInfo>[]);
      } else if (response.statusCode == 300) {
        final carListSimilarities = CarAdditionalInfo.fromJsonList(
          jsonDecode(response.body),
        );
        return (const CarInformation(), carListSimilarities);
      }

      final apiError = ApiError.fromJson(jsonDecode(response.body));
      throw InternalApiError(
        apiError,
        apiError.message,
      );
    } on FormatException {
      throw IncorrectJsonFormat(
        "Information with incorrect format. Contact support.",
      );
    } on TimeoutException {
      throw TimeoutApi(
        "Time exceeded. Try again.",
      );
    } on InternalApiError {
      rethrow;
    } catch (e) {
      throw UnknowError("Error! Contact support.");
    }
  }
}
