import 'dart:async';
import 'dart:convert';

import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:challenge/app/utils/cos_client.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future<void> searchCarByVin(String vin) async {
    try {
      final response = await CosChallenge.httpClient
          .get(Uri.https('anyUrl'), headers: {CosChallenge.user: 'someUserId'});
      if (response.statusCode == 200) {
        print(response.statusCode);
        final newResponse = CarInformation.fromJson(jsonDecode(response.body));
        print(response.statusCode);
        newResponse;
        print(newResponse);
      } else if (response.statusCode == 300) {
        print(response.statusCode);
      }
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
