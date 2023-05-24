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
    // final carListSimilarities = CarAdditionalInfo.fromJsonList(
    //   jsonDecode(status300),
    // );

    // return (CarInformation(), carListSimilarities);

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
        return (CarInformation(), carListSimilarities);
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
        "Information with incorrect format. Contact support.",
      );
    } on InternalApiError {
      rethrow;
    } catch (e) {
      throw UnknowError("Error! Contact support.");
    }
  }
}

const patternMatching = '''{
  "id": "123123",
  "feedback": "Please modify the price.",
  "valuatedAt": "2023-01-05T14:08:40.456Z",
  "requestedAt": "2023-01-05T14:08:40.456Z",
  "createdAt": "2023-01-05T14:08:40.456Z",
  "updatedAt": "2023-01-05T14:08:42.153Z",
  "make": "Toyota",
  "model": "GT 86 Basis",
  "externalId": "DE003-018601450020008"
  "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
  "price": "123123",
  "positiveCustomerFeedback": true,
  "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
  "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
  "origin": "AUCTION",
  "estimationRequestId": "3a295387d07f"
}''';

const status300 = '''
[
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU5, 2012 - 2015",
        "similarity": 98,
        "externalId": "DE001-018601450020001"
    },
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU6, (EURO 6), 2015 - 2017",
        "similarity": 50,
        "externalId": "DE002-018601450020001"
    },
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU6, Basis, 2017 - 2020",
        "similarity": 0,
        "externalId": "DE003-018601450020001"
    }
]''';
