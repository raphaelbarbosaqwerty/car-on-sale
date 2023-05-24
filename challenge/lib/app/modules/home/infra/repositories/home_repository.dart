import 'dart:async';
import 'dart:convert';

import 'package:challenge/app/core/domain/errors/api_errors.dart';
import 'package:challenge/app/core/domain/models/api_error.dart';
import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:challenge/app/utils/cos_client.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future<(CarInformation, List<CarAdditionalInfo>)> searchCarByVin(
      String vin) async {
    try {
      final response = await CosChallenge.httpClient.get(
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

      // Error with INT number
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
      print(e);
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
