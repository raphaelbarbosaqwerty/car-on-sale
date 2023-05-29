import 'package:challenge/app/core/domain/errors/generic_errors.dart';
// coverage:ignore-file

sealed class HomeErrors extends Failure {
  HomeErrors(super.message);
}

class VinCodeEmpty extends HomeErrors {
  VinCodeEmpty([message = ""]) : super(message);
}

class UnableToCacheSuggestions extends HomeErrors {
  UnableToCacheSuggestions([message = ""]) : super(message);
}

class UnableToGetSuggestions extends HomeErrors {
  UnableToGetSuggestions([message = ""]) : super(message);
}

class UnableToSaveCarInformation extends HomeErrors {
  UnableToSaveCarInformation([message = ""]) : super(message);
}

class UnableToGetCarInformation extends HomeErrors {
  UnableToGetCarInformation([message = ""]) : super(message);
}
